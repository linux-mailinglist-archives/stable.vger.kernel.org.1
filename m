Return-Path: <stable+bounces-86040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E0C99EB61
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712471F25495
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EEB1E3DD1;
	Tue, 15 Oct 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSVXLtuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CE1D5AC6;
	Tue, 15 Oct 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997570; cv=none; b=NKWDAdCjTSiaULenhVqqfvYMmKLCXfqWErGJWyR13xxTYWZSFAMuO2n3kzNMrJK/VIIuJ+Ob+2Pv8Fr0wd9hZr9Q40/9JUqjPSF7J/pqSbBPwX/NCCPepR21UACRZi5SmdQBoCTKNha8m3ym6hi25+qO21ZwSRecsSfA6sYSaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997570; c=relaxed/simple;
	bh=h1JBPwoUHB1MIXEbd65gML02EHE4NAirxGLXLWm2lIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpT100e8qfveM2Dtz3ojezd9Ne+t28lb4r9EKOsrkUNCk11CXevWxvHotKdBoWJl446ZObzVzB/iZKlIc2y1lSO6yFBI3PNtyamYBHVR1MCiSfS0iENpilyItOF2+i1udi4+M9dAeQobyJ+zF+fEvPsOM5HmDmsQyDzvhDc+Jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSVXLtuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F8C4CEC6;
	Tue, 15 Oct 2024 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997570;
	bh=h1JBPwoUHB1MIXEbd65gML02EHE4NAirxGLXLWm2lIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSVXLtuFSL8A74j6OaCTgZmu06CNSQCmPlcBDhP+rpVs4iJie4zbWYR7wvNT5a3LA
	 TUmVVqaRh5bqYrwkG6CqydVRMqXW5Vj4bk43192IKfm5oRR/QA0+YcfiEcdY0aeUJm
	 CFNger1vns4Ztv3kIbTevcjuY/fIC0uGsMOIXZ/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 221/518] Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table
Date: Tue, 15 Oct 2024 14:42:05 +0200
Message-ID: <20241015123925.527329502@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Sembach <wse@tuxedocomputers.com>

commit 3870e2850b56306d1d1e435c5a1ccbccd7c59291 upstream.

The Gen6 devices have the same problem and the same Solution as the Gen5
ones.

Some TongFang barebones have touchpad and/or keyboard issues after
suspend, fixable with nomux + reset + noloop + nopnp. Luckily, none of
them have an external PS/2 port so this can safely be set for all of
them.

I'm not entirely sure if every device listed really needs all four quirks,
but after testing and production use, no negative effects could be
observed when setting all four.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240910094008.1601230-3-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/i8042-acpipnpio.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1141,6 +1141,13 @@ static const struct dmi_system_id i8042_
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,



