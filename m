Return-Path: <stable+bounces-197075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE6C8D6A4
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 09:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EA4B4E1AE0
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0D32143E;
	Thu, 27 Nov 2025 08:57:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.nextryonl.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27798320A3C
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233823; cv=none; b=m+icTqLeEQgo6ZG4TFVH+DhO6VO7occI5aO1k0A9Cv124g/O9Pvrye6PjaCHl4cyXl62Zm/bbjDTfMsveJ57Tx/ESMXz5Tqs9pTUwD3fOeXR/7NxWfWauCd77nc/b5MTncnUI9O8RZDvfEnZ298f5b9ELIYEe3AgFpgdrQ9vWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233823; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=htzbwFEyqQHhzkj2yNUJ9f17doJ4emLkmn5xsO2RiqqYml3HfZRsAnTOeeJ7xFFhQm1zrv5ynSSKmK24PANMAeaubvORCk4dwDMgiGQQlEKjq08J253xY57jXeiRv3NNDBU7NkWLccRZWFk8XOYlyLa0l0tROjrrRISfHUJp8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.nextryonl.pl (Postfix, from userid 1002)
	id B95D224342; Thu, 27 Nov 2025 08:50:23 +0000 (UTC)
Received: by mail.nextryonl.pl for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:50:06 GMT
Message-ID: <20251127074500-0.1.64.10csi.0.ceoex47m7n@novencio.pl>
Date: Thu, 27 Nov 2025 08:50:06 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <stable@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

