Return-Path: <stable+bounces-108961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E8A12122
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C08A162485
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85F248BDC;
	Wed, 15 Jan 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r30CWYVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F9248BA6;
	Wed, 15 Jan 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938388; cv=none; b=WxDH2QrUSIBrFac+6qHKPCZT3K6tEWxgOkjK7VIsIQXAXUeevcuK4EgCVkHlnJjE5C0WRUir6jpdfkrxn2vchTtn8yu29VVLC+xRJm1QrM1f6V5dAhrQecp264duy2sCuK0DO2S4C+wB+lh3CKIfEZJU8a7/6J1TUpFi7JtPLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938388; c=relaxed/simple;
	bh=ZJB3AYrLeKIW/gL+G3BJ85J+kjnLkCCQw3CbU9G7qKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrHaQ+jP2EMk91NR9nYJ6rabQLUfboRUHI8R8m8gv8dmO6HaKIoeh0N7SMcsRvhsg1LYNSMFKxBPXpXjbo4k5cM7ryOe8q77PCHmixFjpWP2Eu1VfmMdL+YaTpOLtwy+fd2/zivwCynLIYW20vg6NDtvwTFUVHSTFS3bxTfCwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r30CWYVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B71C4CEDF;
	Wed, 15 Jan 2025 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938388;
	bh=ZJB3AYrLeKIW/gL+G3BJ85J+kjnLkCCQw3CbU9G7qKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r30CWYVGWXKX59MY2yCiRpKP12O7PTabUCrFL6ihg9qgtsnq+nVsNRk/RL+fhNSwE
	 ZcWGbJmjyfQ9RYb0oimkZfVloLhLgIxKV3zOPt7JIZ8vqeHodY7YHszkq232B2d+qZ
	 OrDGjWQXHdlrhJujiHpHHE8jPzvf3Fx4H5uH51m8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 160/189] iio: light: bh1745: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 11:37:36 +0100
Message-ID: <20250115103612.789360181@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit b62fbe3b8eedd3cf3c9ad0b7cb9f72c3f40815f0 upstream.

The 'scan' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-7-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/bh1745.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -750,6 +750,8 @@ static irqreturn_t bh1745_trigger_handle
 	int i;
 	int j = 0;
 
+	memset(&scan, 0, sizeof(scan));
+
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
 				       &value, 2);



