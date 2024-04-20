Return-Path: <stable+bounces-40329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993D8ABB18
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB65C1C20CB2
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBAF29CFA;
	Sat, 20 Apr 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ideIYVRx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6E1863E
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610344; cv=none; b=BxURN3qwetubFEH/uigYq9PyitxSN0D8iKVLIxOJ/NO4xvNrRe7xVZI0OIQPUNKi5Rej9uCqHa92XkcFKLDa/6kdHBrRkGBcChUs2hjiu0Ek3LiatJO5Oy2WZX9Z9UCU8XN8O0Czos+cVIkQhP7++ePuae46HUnpVDx0rEe/YCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610344; c=relaxed/simple;
	bh=DP9OpOeXRPwntTaq8fa0UBaputP6jYZlg/h2/DT83TQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a5JydUCY/ZGTjP7df0wCXZTKI1HNICePYveNxbh7HlLKlq5+3FrKt81dSnqauEO2HuO0jpPsSuSFrfJUYKlpYWBJA6u8leRWt6vJWBgFQXlliOV3tk6J/Z47QSItc+JK9BsSwW44hqZo0WBl568K1ih52Ou+8lNjfWaKIWU0vzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ideIYVRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 287C9C072AA;
	Sat, 20 Apr 2024 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713610344;
	bh=DP9OpOeXRPwntTaq8fa0UBaputP6jYZlg/h2/DT83TQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ideIYVRx6wkpyASwkpSjB4Jp7C+NUeRE8SYaP9IX55CNto+SPZiqI+/MGCAe5MWy4
	 aggnLCVjcHjsMQ2ZqFChziIGo81tNAkhuQfhw0qff8LUf16Cdo+aq+AyXws8rfYRKl
	 cuJF8MDtYYm35E0E/+k9R3Xr25gIE3Z9ugNeT6DWcvx+XF7HGD68/Umvup41yM0CiV
	 VY7KQHGenwJZCrqb0FQSpn4hjlZcotLDgpW+uUHV2mMxLGvi9nhhwLLgzA8M27RhVR
	 f2/P1xNq4zzKIT0VTwitipQFWG1FVcdmRNGTbIlTk5Ry6M3hwZrl637M3YShKMYz4i
	 XXaqCkfwW/oDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17028C4345F;
	Sat, 20 Apr 2024 10:52:24 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/2] Please apply these MT7530 DSA subdriver patches to 6.8
Date: Sat, 20 Apr 2024 13:51:51 +0300
Message-Id: <20240420-for-stable-6-8-backports-v1-0-4dafb598aa3b@arinc9.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEeeI2YC/x3MwQqDMAyA4VeRnBdIi8rwVWSHtku3MGklERmI7
 27x+B3+/wBjFTaYugOUdzGppcE9OkjfUD6M8m4GT76n3hPmqmhbiAvjiE+MIf3WqpvhELyjPKY
 cKUHLV+Us/3s9v87zAhe0ShJqAAAA
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713610341; l=797;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=DP9OpOeXRPwntTaq8fa0UBaputP6jYZlg/h2/DT83TQ=;
 b=rbKN+LolXtsdp2/H6lsyjNyvwYK/9Ol2EDcAlYlQOUTRKV5E5Gze+uJGBHJCqyuO542+A7zIL
 Fy0jXQIml0KAR/5lksMi9LJA5g+JLSLieBje3mD3b+esrM5sK1LUEJb
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

These are the remaining bugfix patches for the MT7530 DSA subdriver.
They didn't apply as is to the 6.8 stable tree so I have submitted the
adjusted versions in this thread. Please apply them in the order
they were submitted.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (2):
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

 drivers/net/dsa/mt7530.c | 22 +++++++++++++++-------
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)
---
base-commit: 12dadc409c2bd8538c6ee0e56e191efde6d92007
change-id: 20240420-for-stable-6-8-backports-5a210f6cfb0c

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



