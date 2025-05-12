Return-Path: <stable+bounces-143584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8309AB408E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28388C0013
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056AB296D2B;
	Mon, 12 May 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hoxUoSWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C042550C6;
	Mon, 12 May 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072424; cv=none; b=j/pnTTC4QhLtYCiX8wX4voP19f7UTIbEAhjzHGg1H/dq0aQUYUxQclLSSnSocRihKXM2q5pk+E4HmsErt2b3wpwqWtNjKYhjltQw7ifzfw7ubUpvTYIyvVMAXOQNofgs7+DuTHjLUOPSWO7ARbaWyZx6gGq4JL4/IzqfDMgS7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072424; c=relaxed/simple;
	bh=KSZtoJvLqrze0QuAuyzRfbwsma1tZxSoJKZ3kN1SDAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2W/RKWRD5hfFB8L4xYZyL+wdr2pjZ9YsPTjTVEPj+TaqjXqIYHZ9yAAX23uxS43lDP+C41qBsmPAAPL4lHGMAUZB3N7s2QJA4kgpRKCNyz0RMarhlAqYDkv6NEKp0SQmzRt3F6GLZchvK0defgU+V545o8EUR8Hwx/lvedwvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hoxUoSWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B7C4CEE7;
	Mon, 12 May 2025 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072424;
	bh=KSZtoJvLqrze0QuAuyzRfbwsma1tZxSoJKZ3kN1SDAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoxUoSWCmlwHW4IVVvLug3lgiivKz7NH8X0/6/LYudhrPF66U5nKAAj5mM/Pqp7ox
	 A3Yk4AadkyCOFY6MRG7335wN3IcLPJA3dEjrcRYx1mdSHQrSjK/hUmheGQl4UW7YD8
	 kX8qNEByUwT6FhNfdxxeswoOWB07+Miy1DKNHtSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Silvano Seva <s.seva@4sigma.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 37/92] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo
Date: Mon, 12 May 2025 19:45:12 +0200
Message-ID: <20250512172024.635678379@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Silvano Seva <s.seva@4sigma.it>

commit 8114ef86e2058e2554111b793596f17bee23fa15 upstream.

Prevent st_lsm6dsx_read_tagged_fifo from falling in an infinite loop in
case pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20250311085030.3593-4-s.seva@4sigma.it
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -590,6 +590,9 @@ int st_lsm6dsx_read_tagged_fifo(struct s
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,



