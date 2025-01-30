Return-Path: <stable+bounces-111373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF8A22EDD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7877A25E5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAE919DFAB;
	Thu, 30 Jan 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGdCgxM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384771E98E7;
	Thu, 30 Jan 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246549; cv=none; b=jSCv/qxffoxIOn18PKD7xJtZVYv9P8s2lCVtiswiw2B55dyLcPKUweJwVxmKvYdpepDp6Y9npZrzoM8zZ1H/tdXv9t3ggLzU3HN57nDK9t6EVfb2iKOw8HrOwCEj5dTjSXNxTptUuShi6Vlud2obHYQy7x/NpadGaWm/93yUvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246549; c=relaxed/simple;
	bh=p2ZFIyJUongCPJ7jAipywNJCtXIQRJEE6BaF8cGO9l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF9uUYgymywOvYS50td/mWpmHBDDlRfg1QHiuzXS2+oOvKMGgp/UIVxWS7x1M1E4BEWv3MxcRnQ0auaLJmQlI33LtyOOzyZKD/GmmmvT7wfT77/b+a8X9JJ+ZAmAjSWd+tTJoalNpH4iZyvr4dNM2GxMcOffAhPtBFKQLK1s7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGdCgxM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514DCC4CED2;
	Thu, 30 Jan 2025 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246548;
	bh=p2ZFIyJUongCPJ7jAipywNJCtXIQRJEE6BaF8cGO9l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGdCgxM6FPHHd4IO658jiEYq6+ILPYDf3B7PPC7OEmFAIo6DnnGXvRU887CCCV9i6
	 gGr6LAmUwo6wOnsjoHus0ILFFGvwMiseO4toH2yFdoJGg0vUouzRhmcfKKU5HmN+Wy
	 AgXHb7d72Jf25c+63QUvHokRqH79tOJ9V5S06sts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mostafa Saleh <smostafa@google.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 6.6 30/43] vfio/platform: check the bounds of read/write syscalls
Date: Thu, 30 Jan 2025 14:59:37 +0100
Message-ID: <20250130133500.114595736@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

commit ce9ff21ea89d191e477a02ad7eabf4f996b80a69 upstream.

count and offset are passed from user space and not checked, only
offset is capped to 40 bits, which can be used to read/write out of
bounds of the device.

Fixes: 6e3f26456009 (“vfio/platform: read and write support for the device fd”)
Cc: stable@vger.kernel.org
Reported-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/platform/vfio_platform_common.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -388,6 +388,11 @@ static ssize_t vfio_platform_read_mmio(s
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);
@@ -467,6 +472,11 @@ static ssize_t vfio_platform_write_mmio(
 {
 	unsigned int done = 0;
 
+	if (off >= reg->size)
+		return -EINVAL;
+
+	count = min_t(size_t, count, reg->size - off);
+
 	if (!reg->ioaddr) {
 		reg->ioaddr =
 			ioremap(reg->addr, reg->size);



