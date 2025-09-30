Return-Path: <stable+bounces-182663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D3BADBE2
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A75B170929
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01A173;
	Tue, 30 Sep 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q6fZkiQi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75B205E3B;
	Tue, 30 Sep 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245680; cv=none; b=uKKsY0eL3fT+RZy06e2+hUMldPqML1w8+6FNrawY9cU2m+rQe5BLIzrhu+jBZ4NkdrPUsEg3A6pyVMVCYrUKV5CsmxoMf9UWLEjO4QaaYZyo87RnbqjAjcULZf/p/08liF/WkrJxlXK+/pfck8rR7H6+XhrcbWYLDvUTFkeM+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245680; c=relaxed/simple;
	bh=Sfj4yhQFu4/BNuLtyaOl8IPgUtZM07GtWB4it4Zj4K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGhGyMruIUlasJzLn6aGwqn/8guFqqJUpU/T43ShhnyiNzdED+LV5gogEomgsWPsgZ/TYAyvemVpBgHamPRUHUUcGUFv14DWGHANIE769OzS1kvc4TvQLWmtvlI3TsBJcNc1t/1j2BYWPX8wrh9h/dig7FmwL2bmHA+FqZvfDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q6fZkiQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A6AC4CEF0;
	Tue, 30 Sep 2025 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245679;
	bh=Sfj4yhQFu4/BNuLtyaOl8IPgUtZM07GtWB4it4Zj4K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6fZkiQihhYuVFhBVxvqXKes+N8vzHG0dvIXCP64qYNdb/i0GRDskughjNZdI8YhE
	 apsGtEXqqnhVXChOhpU8KuX5lKo0CFuRLgfPd/LxpRx6I3SOotiqERNk8OyfzPa7w9
	 tvfINY+qjOTZtKR1sW6Hv4zSxIcffXFxG4HpJ3H8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"noble.yang" <noble.yang@comtrue-inc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 18/91] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Tue, 30 Sep 2025 16:47:17 +0200
Message-ID: <20250930143821.888042942@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
References: <20250930143821.118938523@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: noble.yang <noble.yang@comtrue-inc.com>

[ Upstream commit e9df1755485dd90a89656e8a21ec4d71c909fa30 ]

The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
the CT7601 which are capable of Native DSD playback.

This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which enables
native DSD playback (DSD_U32_LE) on their USB Audio device. This has been
verified under Ubuntu 25.04 with JRiver.

Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>
Link: https://patch.msgid.link/20250731110614.4070-1-noble228@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index f19c808444c97..def326ddef267 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2305,6 +2305,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
-- 
2.51.0




