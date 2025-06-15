Return-Path: <stable+bounces-152675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF32ADA31C
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 21:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8553F188DD9D
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C227C877;
	Sun, 15 Jun 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="O8u9Lu9B"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26409279DDE;
	Sun, 15 Jun 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750014432; cv=none; b=chUurlx5bkId5AOQFjLbJCleiz8Gv7xcjWm4desMKxhufjok0EcWxGUsYyRuaE3dstcFUwcXQVuRUigyQEb4WsoGUlK36WaDOvl/4Ih1/hwOXXpL6tq9+J2X2Occ3LoWPmuvUet2M18asu+2tGWCtPkKQejJphXF3Reya3ZesMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750014432; c=relaxed/simple;
	bh=1qOLzufjUa8Zh4euK/fDgct+cuVX+oHhcsqdIhIi9DE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rcZwGlfNXzy2uVTdMTz55Fr3XyGQaZdk74b1Hkfxk7eOIxwq3vlCiRiD9h80D3nSF1NlOUmZAOQtZWrvNMY/kI1nB33yL8ezWoKOCibtH4k66pY8D1sIGzLvwCfxGnjaQ7dlJNos3I7MxhXl/QgpG/FZQbQVrO9eg4BOdE9SHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=O8u9Lu9B; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 959547D326;
	Sun, 15 Jun 2025 21:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1750014428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLJxH53u4rIp7lk/J8Gc55Z9A9rhc0rguCf2meLYQG0=;
	b=O8u9Lu9BsbQxQBXknX1fhijaVcV/HQh7B48nschiBTDSIsTWLmCSw6YHetRMEVlwwDzeX2
	bgCHFIX4d3enS+Y1QgZhoPFcTlheEBfmaPehuOtKLmXYdQe5s4BZTpRFROI4WmujpyHwVL
	vxykzqp5mYAuU2TdYsZGz8503ETK8+U=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Jun 2025 21:07:06 +0200
Message-Id: <DANCC8SXYZ90.R0EMMZXG9UIX@pwned.life>
Subject: Re: [PATCH] kallsyms: fix build without execinfo
From: "fossdd" <fossdd@pwned.life>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1
References: <20250601183309.225569-1-fossdd@pwned.life>
 <2025060248-splendor-riverside-c8fe@gregkh>
In-Reply-To: <2025060248-splendor-riverside-c8fe@gregkh>

On Mon Jun 2, 2025 at 7:50 AM CEST, Greg KH wrote:
> On Sun, Jun 01, 2025 at 08:32:50PM +0200, Achill Gilgenast wrote:
>> Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
>> Cc: stable@vger.kernel.org
>> ---
>>  tools/include/linux/kallsyms.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> I know I can't take patches without any changelog text, but maybe other
> maintainers are more lax.

Oh right. Added in v2:
https://lore.kernel.org/stable/20250615185821.824140-1-fossdd@pwned.life/

Thanks for the feedback.

