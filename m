Return-Path: <stable+bounces-62144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A933D93E59D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527C21F212AC
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CDB4204F;
	Sun, 28 Jul 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="n7TNWIK8"
X-Original-To: stable@vger.kernel.org
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D892E64A
	for <stable@vger.kernel.org>; Sun, 28 Jul 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722175942; cv=none; b=M4QjI7kTXCsc9MK+2/3dCkVHveucKjoA8EUTQB1cf9VExwSDDq6/jP7vrknITBBTXY8AhYsxkbkf3CDdH/AywHXYz6KmEzaYpV0iGKltXfrPauvwdDh1JoFAAhUFsPXv9nEBOVKpOCQ6IbogDZoNxrBa1Hh7czQT/2hnSZlbsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722175942; c=relaxed/simple;
	bh=2HeQIoooXFrfX+pxOO0zC70ngk86slekhNzGZnDyE00=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LeCZrxgISw3fwkUAdwCr3sPKKzID0wmxn8179in7fIfzU19v1C7uGxpZ+LViF7sBNeXLDnRm3ijmuQdQck0QzbzXBqbWIe0HTPH40Npv89YAz1vjSpMtAXqxgFxVasien2wIw78NHJ0jv2VC9JXJSTyndRr203xiDMvnAsQujcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=n7TNWIK8; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722175938; x=1722435138;
	bh=70i7xd+3vPiK1ea5e202MHm5v82BeemX0FVIirCPsXA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n7TNWIK8GqHXJ0psPCJCUQ+Kic7fWVX2AGbfl0ACxIKr5IoGbrJE8VbHSpLzy2olZ
	 UipVx9zZ/HaIlsLekMhzAg5GoTnOQakn9y2Bi5XDpj+3NvqxoaHG4brdqjzjKVqts3
	 Xbe0QjfAzN/Ss99+5YhjnYL7v+CZApNRxZXKoJaQjnGzPTcsznAMkvkwRPri1glNSb
	 MAbpVIQdcVi9mFXF6H1zL5CkUIKOczLzKZs8f4iPed6eJjSZLDoTplRfo2sB/1Kenr
	 YjHd2BEixz9j9GFl9nZzRmydLBHDNpaYNqGWHkzj43i2w+WE4gzMYhMHLVmhWMLymn
	 275uuViWT5JSA==
Date: Sun, 28 Jul 2024 14:12:14 +0000
To: o-takashi@sakamocchi.jp
From: Edmund Raile <edmund.raile@protonmail.com>
Cc: edmund.raile@proton.me, gustavo@embeddedor.com, stable@vger.kernel.org, tiwai@suse.de, Edmund Raile <edmund.raile@protonmail.com>
Subject: c1839501fe3e tested
Message-ID: <20240728141141.704375-1-edmund.raile@protonmail.com>
Feedback-ID: 43016623:user:proton
X-Pm-Message-ID: de65c5a97c58efcc614e261a918c247996743c69
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

c1839501fe3e ("ALSA: firewire-lib: fix wrong value as length of header for
CIP_NO_HEADER case") indeed fixes the issue.

Thank you very much!

I just hope non-CIP_NO_HEADER cases work, but then again, looking at the
original struct
```
struct {
        struct fw_iso_packet params;
        __be32 header[CIP_HEADER_QUADLETS];
} template =3D { {0}, {0} };
```
the fw_iso_packet wasn't at the end of the array, thus
```
struct fw_iso_packet {
=09u16 payload_length;=09/* Length of indirect payload=09=09*/
=09u32 interrupt:1;=09/* Generate interrupt on this packet=09*/
=09u32 skip:1;=09=09/* tx: Set to not send packet at all=09*/
=09=09=09=09/* rx: Sync bit, wait for matching sy=09*/
=09u32 tag:2;=09=09/* tx: Tag in packet header=09=09*/
=09u32 sy:4;=09=09/* tx: Sy in packet header=09=09*/
=09u32 header_length:8;=09/* Size of immediate header=09=09*/
=09u32 header[];=09=09/* tx: Top of 1394 isoch. data_block=09*/
};
```
its header array wouldn't ever end up being initialized here with > 0 eleme=
nts.
Maybe that wasn't ever required.

Tested-by: Edmund Raile <edmund.raile@protonmail.com>
Link: https://lore.kernel.org/r/20240725155640.128442-1-o-takashi@sakamocch=
i.jp


