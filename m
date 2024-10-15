Return-Path: <stable+bounces-85433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FA99E74D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2501C26107
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5031D5ACD;
	Tue, 15 Oct 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMuyfUo9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0181CFEA9;
	Tue, 15 Oct 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993099; cv=none; b=ke9CuMyiqZOYhUblRDliJcV2plvDkx7dfkRxPtOWtTt1huFY8eGXW9SShhAO45M/yDu7R2o1rTXdUoG3PXDq9kWKJlzZHHp6ueNgwVAqo23AZ4MT25i0xAasDTj1GZaJ0FGnCwdwsHhjsdUAS2QGwjV8ZZfyWdcI1cNEWItqBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993099; c=relaxed/simple;
	bh=wDCYrBFF4o83+ZhaEcuMu3+UNA4E31wY49YGjT4clF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msy1H5jXcXSoFwoAikxEbHjB+xkp/C76mjaEsPqQZlffaURvfVkqkiZBYi5Dutr5W25tM7WTDnUNMiyZhTQbhOXBH4cCXmLsV8MrthxhfThMIHFglw5PTPFy71V5xPJjF0z9+rRLjolPynAgr1r0731YdE9th3G1+CunHvWZvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMuyfUo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051ECC4CEC6;
	Tue, 15 Oct 2024 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993099;
	bh=wDCYrBFF4o83+ZhaEcuMu3+UNA4E31wY49YGjT4clF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMuyfUo9kduRGZKT05Ch072VbQANTRjaCfqZx1OQjTBrSPf49zoK7/7HUtOzSyDhI
	 nvUhXNwLPqYQgZ79U9/86K4fD8Rprp6g749W0zc950Te5ofolci/WUeUjJ+esTAupv
	 iL3sPSCVDLPmWzOxQuX6m5HyXPy9EQHVKhEVxLy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Roman Smirnov <r.smirnov@omp.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.15 309/691] Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"
Date: Tue, 15 Oct 2024 13:24:17 +0200
Message-ID: <20241015112452.603839202@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Smirnov <r.smirnov@omp.ru>

commit e25cc4be4616fcf5689622b3226d648aab253cdb upstream.

This reverts commit b9302fa7ed979e84b454e4ca92192cf485a4ed41.

As Fedor Pchelkin pointed out, this commit violates the
convention of using the macro return value, which causes errors.
For example, in functions tda18271_attach(), xc5000_attach(),
simple_tuner_attach().

Link: https://lore.kernel.org/linux-media/20240424202031.syigrtrtipbq5f2l@fpc/
Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/tuners/tuner-i2c.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/media/tuners/tuner-i2c.h
+++ b/drivers/media/tuners/tuner-i2c.h
@@ -133,10 +133,8 @@ static inline int tuner_i2c_xfer_send_re
 	}								\
 	if (0 == __ret) {						\
 		state = kzalloc(sizeof(type), GFP_KERNEL);		\
-		if (!state) {						\
-			__ret = -ENOMEM;				\
+		if (NULL == state)					\
 			goto __fail;					\
-		}							\
 		state->i2c_props.addr = i2caddr;			\
 		state->i2c_props.adap = i2cadap;			\
 		state->i2c_props.name = devname;			\



