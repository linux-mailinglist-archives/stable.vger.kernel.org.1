Return-Path: <stable+bounces-162976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F0B060BA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CA65A05BF
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF62ECD36;
	Tue, 15 Jul 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwyWKg7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4E2ED14E;
	Tue, 15 Jul 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587971; cv=none; b=CtGYAZqERMbB2K/lMETg8hMZSTymS8TTayU3EzJbLPJw7BzLejq985r51Vx4QGZH0q3NL8MJxy2huUIzbbY+kO10SBlJ2oQdJ/O/j0GNlVKeRNr778A6s0BekjJz84sKh5pzlvEeidEbEdvR8IAa2518spF/4ix8oBXCm47PYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587971; c=relaxed/simple;
	bh=yeF8/ItGfJ15wOt4Mk7OmFH7OtdQrorPC+F0jRaXu+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSmR5azDt2/OF3fvkUjISo9CoES4x3IUtayPu9m8iyi1NTuf9FIfggoUdckCjrridVXi9gqnExJoJGj/lp+LijOOKxyysUSSkNQI9V4uEDz2L+lQ0dmSPb1iFnmO51iminmOkYJuk7TeTBai1q0+EeH4GXLf+eHO5170QFkHbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwyWKg7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC4C4CEE3;
	Tue, 15 Jul 2025 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587971;
	bh=yeF8/ItGfJ15wOt4Mk7OmFH7OtdQrorPC+F0jRaXu+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwyWKg7mP6esVOMJE88HamKA7HaW34V1ncI45QWYngmdebXeR7qBgytlxE+NzUc3e
	 diFWEvfbdCawzxjuaRsRtN3g5v7WFtqFkngzkfSIKNIkrCkupHgU55yCoAga2TqGpj
	 yt3lJBzXKbktchcIr4tP371PAT3vG4GZ7AMYNegc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Wang Hai <wanghai38@huawei.com>
Subject: [PATCH 5.10 201/208] Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID
Date: Tue, 15 Jul 2025 15:15:10 +0200
Message-ID: <20250715130818.988855555@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 upstream.

After commit 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in
translated mode") not only the getid command is skipped, but also
the de-activating of the keyboard at the end of atkbd_probe(), potentially
re-introducing the problem fixed by commit be2d7e4233a4 ("Input: atkbd -
fix multi-byte scancode handling on reconnect").

Make sure multi-byte scancode handling on reconnect is still handled
correctly by not skipping the atkbd_deactivate() call.

Fixes: 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in translated mode")
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240126160724.13278-3-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/atkbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -817,7 +817,7 @@ static int atkbd_probe(struct atkbd *atk
 
 	if (atkbd_skip_getid(atkbd)) {
 		atkbd->id = 0xab83;
-		return 0;
+		goto deactivate_kbd;
 	}
 
 /*
@@ -854,6 +854,7 @@ static int atkbd_probe(struct atkbd *atk
 		return -1;
 	}
 
+deactivate_kbd:
 /*
  * Make sure nothing is coming from the keyboard and disturbs our
  * internal state.



