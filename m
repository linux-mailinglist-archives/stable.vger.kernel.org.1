Return-Path: <stable+bounces-132022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47FA835B8
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE439462C30
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 01:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB02AEFE;
	Thu, 10 Apr 2025 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jf-bd.net header.i=@jf-bd.net header.b="JadzC/S0"
X-Original-To: stable@vger.kernel.org
Received: from qmt20.citechco.net (qmt20.citechco.net [203.191.33.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F41DA4E
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.191.33.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744248333; cv=none; b=aSo+6KihyMHS0YkZ0HrsTufy33jtJu7zHdGTVc8hIW8m8Z4mz2m2J5lKqoZDz/4xhNi5RxzmRF5r9pyLKI2xdX48Kvr/ItHlKhilgrPwmJFBUVcA6w31xJIUokIwZZvXu8IxjIw1Z+Yka8xe9g0E0YP5KEuYVLT0zG1V741SvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744248333; c=relaxed/simple;
	bh=hqskI2l0bSS7XdAaXzIxsB/kNb7inziURcq7FFqQol8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uk412hBUEHlfz4uDjcfv5mGat/GHvUm6uVXXWOpic86ObJT0qsPCXxg/JtOWNM1RWV0FYHmy/qEaAD4e5/PpIn4rgCzQsQQ5Se0AM3WllWcsjebQyndwK4OIe7UJvxvD+StZSH/9eIh4yUe7k4SmMrBm6RL4nS7S3ggXwapSuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jf-bd.net; spf=pass smtp.mailfrom=jf-bd.net; dkim=pass (1024-bit key) header.d=jf-bd.net header.i=@jf-bd.net header.b=JadzC/S0; arc=none smtp.client-ip=203.191.33.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jf-bd.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jf-bd.net
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jf-bd.net; h=reply-to:from
	:to:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=bvdyuYZ7equ67DIcwT
	RaVO8VMLAynmmZA+dnyTKzEoZYeEzgYxQ4z3Xy79jHws/7Xp/qYKqWHeO27awRc3
	jtAactIpoRHCkykeTRTzvwOrUmt3SwDkl/gMVQlDIDG2HhAEMAGLYsxLSyGekPri
	h78tD5pRa4OgpANK9hzPJgilg=
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=jf-bd.net; h=reply-to:from
	:to:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=dkim1; bh=BQ4VYQ759GlRs1a2EUBRjVDV
	aZ8=; b=JadzC/S0p79LS0k4S+2/Sql6SNGmTUel0FQLouETPhnZy8sKKLg3KKXB
	tcMkyBZUze2gvLkfuQSOnW43CrB7v82o5UXRjiCDU9S5nzC8hhZW9K+zDkY9OqsM
	septgOegtKCuICXEXFP9E3iLMBFfsIOpv8toJKt3Vaqk7qCzw+M=
Received: (qmail 3677 invoked by uid 89); 10 Apr 2025 01:25:21 -0000
Received: from unknown (HELO 179-190-173-23.cable.cabotelecom.com.br) (commercial@jf-bd.net@154.205.144.222)
  by qmt20.citechco.net with ESMTPA; 10 Apr 2025 01:25:21 -0000
Reply-To: winstontaylor@theleadingone.net
From: Winston Taylor <commercial@jf-bd.net>
To: stable@vger.kernel.org
Subject: WTS
Date: 9 Apr 2025 20:25:19 -0500
Message-ID: <20250409202518.2BCC2B6B7C238171@jf-bd.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello ,
These are available for sale. If you=E2=80=99re interested in purchasing=20=

these, please email me

brand new and original
Brand New ST8000NM017B  $70 EA
Brand New ST20000NM007D   $100 EACH
Brand New ST4000NM000A   $30 EA
Brand New WD80EFPX   $60 EA
 Brand New WD101PURZ    $70 EA

Brand New CISCO C9300-48UXM-E
Available 5
$21800 EACH

Intel Xeon Gold 5418Y Processors
QTY28 $780 each

Brand New C9200L-48T-4X-E  $1000 EAC


 Brand New N9K-C93108TC-FX-24 Nexus
9300-FX w/ 24p 100M/1/10GT & 6p 40/100G
Available 4
$3000 each

Brand New NVIDIA GeForce RTX 4090 Founders
Edition 24GB - QTY: 56 - $700 each

Brand new Palit NVIDIA GeForce RTX 5080
GamingPro OC card with full manufacturer
QTY 48 $750 EAC

BRAND NEW - ASUS TUF Gaming GeForce RTX =E2=84=A2 5080 16GB
GDDR7 OC Edition Gaming Graphics Card SEALED
QTY50  $700 EACH

Condition: Grade A
Used HP EliteBook 840 G7 i7-10610U 16GB RAM 512GB
SSD Windows 11 Pro TOUCH Screen
QTY 30 USD 100 each

Condition: Grade A
Used HP EliteBook 850 G8 15.6" FHD,
INTEL I7, 256GB SSD, 8GB RAM Win11
 QTY50 $240 EACH

SK Hynix 48GB DDR5 4800 1Rx4 PC5-4800B-
PF0-1010-XT 288pin Server EC4 RDIMM RAM
QTY 239 $50 EACH


-----------------------------------------------------------------
---------------

Best Regards,
Winston Taylor
300 Laird St, Wilkes-Barre, PA 18702, USA
Mobile: +1 (570) 890-5512
Email: winstontaylor@theleadingone.net
www.theleadingone.net

