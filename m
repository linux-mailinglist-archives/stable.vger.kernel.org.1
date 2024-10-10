Return-Path: <stable+bounces-83304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E2997D9E
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 08:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC82282E7B
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27EE1A3BDE;
	Thu, 10 Oct 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b="MByJbtZy"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C129A2;
	Thu, 10 Oct 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543126; cv=pass; b=m8GiADB3Yor2SgmzCutwWxiMXQIRAIOUDIwIIQBW10xAJSN0EUsvE3LsyFMn59Ul+TPnU+I/qnOfFNrzADu0oMfEp4p7PdrNFGxaOS7J/RGcwjpZ9vdfV/boyYkF6yMKbdAxoxpC8JncGt21aMPM29SmpPI7Q8FWdaMDNA5XGe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543126; c=relaxed/simple;
	bh=vVgWuH7tvKPKwsxq5MoeNptohdViKzQtQtHhCjZ4uHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fxxxp2SgOctDRfnXgyRJdanZJAbwkOutcfkBCAvhehbxmnorZdg9KYIcdi2s0jxfDGjls3ghZzLy53ICGFaHFrOIsA+j7RSq/t5mE0M60hGveTvCHCMLhi+P+Lhf8bUuwY1gI25/QsAM/oO0ia1p6xSkh787RgEMg+crTHQJD/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b=MByJbtZy; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
ARC-Seal: i=1; a=rsa-sha256; t=1728543097; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hrjnByiJVDHCSRCJXvzR/jsvKWYPYiWoww+FaDE86j6vur6Iupid6W7rP422FozYsoYu4ekBcxZd4wJWoKgsaO7/ldSBCwo6Fhrekf2alXyF8aiG1/63Xknn2RraFKAnzI1kl10pcvs5lYoK0u4F79kT0V7ssTbtMBe2q8R+0jw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728543097; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NV4NWAt9hLTFZ48/H5oHJi+3QjFHmFEiaguAd0fABeE=; 
	b=Mc0ByOphW4AAji+DreRmfINmIBHlh25Yu+nKLkPzd2bHJmE3DhjUcwBW5E9Aa8ON4vD4gw+xYS9oG+oSDaIE0cvKfuTD24e6OhXeODAe9RwvLjXV0pGoYEcSDtxe155XzorUGFqM9p+rPeNmSMRnjE7fDfut6V21/HXbXemW9Nw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.co.uk;
	spf=pass  smtp.mailfrom=andrew.shadura@collabora.co.uk;
	dmarc=pass header.from=<andrew.shadura@collabora.co.uk>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728543097;
	s=zoho; d=collabora.co.uk; i=andrew.shadura@collabora.co.uk;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NV4NWAt9hLTFZ48/H5oHJi+3QjFHmFEiaguAd0fABeE=;
	b=MByJbtZy6GHwmSyoRvl408/Qy+KCHWHsPPKun+RZ1nT+HZU3Oncg59xRNDUaKiu5
	rxHle9Ic0a7wK0T9w85ut/0OHVLjT9+PFdKr15m+cjWE416fL8FNe2ENwOB/NxgCCkS
	RAwz+DcC45BMHvFFnG2wYfFHoSyxjC2TIds913g4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1728543095946469.6596726420195; Wed, 9 Oct 2024 23:51:35 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:51:35 +0200
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: "David Laight" <David.Laight@ACULAB.COM>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "Nathan Chancellor" <nathan@kernel.org>,
	"Justin Stitt" <justinstitt@google.com>,
	"Aleksei Vetrov" <vvvvvv@google.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"George Burgess" <gbiv@chromium.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <19275327c49.127586e67766243.1356460097137208113@collabora.co.uk>
In-Reply-To: <49c81d21778b4ef5a7ab458b359a9993@AcuMS.aculab.com>
References: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
 <49c81d21778b4ef5a7ab458b359a9993@AcuMS.aculab.com>
Subject: Re: [PATCH v2] Bluetooth: Fix type of len in
 rfcomm_sock_getsockopt{,_old}()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

On 09/10/2024 18:37, David Laight wrote:
>> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
>> optimisation change in LLVM main:
>>
>>> len is defined as an 'int' because it is assigned from
>>> '__user int *optlen'. However, it is clamped against the result of
>>> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
>>> platforms). This is done with min_t() because min() requires compatible
>>> types, which results in both len and the result of sizeof() being caste=
d
>>> to 'unsigned int', meaning len changes signs and the result of sizeof()
>>> is truncated. From there, len is passed to copy_to_user(), which has a
>>> third parameter type of 'unsigned long', so it is widened and changes
>>> signs again.

> That can't matter because the value is a small positive integer.

I agree that it shouldn=E2=80=99t, but it does in the currently released Cl=
ang=20
version until the bug is fixed.

--=20
Cheers,
   Andrej


