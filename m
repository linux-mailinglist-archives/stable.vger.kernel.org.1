Return-Path: <stable+bounces-164298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E40B0E599
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0236958098C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150527CB35;
	Tue, 22 Jul 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3U46rpl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70810238C1F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220256; cv=none; b=FrRyGoEVVri3UwSL82wdw6hinb/Ti0bgug2djK7K4d0JyuJdhRQTiX7pQNi8k2GkeTT6eEi3pSJB/C45G30GkWE3v0opaBlFhGRdz44Syqi2xO2vSFT3+5EW8x9FqLBsdPWdI6z2xb+aqzfnHs+4g0JM7WSRRYxpO3B6H8zfoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220256; c=relaxed/simple;
	bh=r68BlRkATGHtvKy1BUfT6GQJEYaYJZogOj0fm+tRIX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GMlrq73ltsgIozZx5JkS7WVTzjjZo/G4/1fYFx+DEtiOqi3eZ3OMqOCRgXESSMTNObUEkOjwYFxyijLZPvhiaJbquv4+pb9GfriPPA3K7r4zlzhTFNLsgAa/poas2JU5svTex7zKBf9mvh7rN5NtKxJKc4O8zeT9YIcX41CPJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3U46rpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D35C4CEEB;
	Tue, 22 Jul 2025 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220256;
	bh=r68BlRkATGHtvKy1BUfT6GQJEYaYJZogOj0fm+tRIX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3U46rplENcYoQv5FQhP3gnIIuJAyHWvTNTKulaMOtbdvWlSoUuVJifkrmXuNts//
	 PEqR8F3iJy3GziELp8uPM3o0sB+z+V80FMinC71E+rzJdfYX6jdsljDlAQQQcVf3cO
	 6N0U3CE1uqsbu3IIkH217D3cWaIDoponnkv5Ow+ffoMi61ph1mbJLmdrejYiuz5PRN
	 q/4lws65oSHQqnHnUyqdCKF4qyc5H0dbOSqKB4jGRc8h4NYD+STcq7bpu4lLszS7rx
	 anyYRa12qwVdyapDQ61YDHfHh/oMKOVciumFEqbo0oZMSSwLi62W6B27giWBIONRAK
	 7U8v7ih4Pn6jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Tue, 22 Jul 2025 17:37:31 -0400
Message-Id: <20250722213731.980366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072153-splinter-buckshot-87f5@gregkh>
References: <2025072153-splinter-buckshot-87f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Abbott <abbotti@mev.co.uk>

[ Upstream commit 1b98304c09a0192598d0767f1eb8c83d7e793091 ]

In `waveform_common_attach()`, the two timers `&devpriv->ai_timer` and
`&devpriv->ao_timer` are initialized after the allocation of the device
private data by `comedi_alloc_devpriv()` and the subdevices by
`comedi_alloc_subdevices()`.  The function may return with an error
between those function calls.  In that case, `waveform_detach()` will be
called by the Comedi core to clean up.  The check that
`waveform_detach()` uses to decide whether to delete the timers is
incorrect.  It only checks that the device private data was allocated,
but that does not guarantee that the timers were initialized.  It also
needs to check that the subdevices were allocated.  Fix it.

Fixes: 73e0e4dfed4c ("staging: comedi: comedi_test: fix timer lock-up")
Cc: stable@vger.kernel.org # 6.15+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250708130627.21743-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced timer_delete_sync() calls with del_timer_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/comedi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 05ae9122823f8..e713ef611434d 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -790,7 +790,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
-- 
2.39.5


