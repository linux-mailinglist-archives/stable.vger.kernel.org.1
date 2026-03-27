Return-Path: <stable+bounces-230701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFd3LvnCxmm8OQUAu9opvQ
	(envelope-from <stable+bounces-230701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:48:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2433489A8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8325302A0E8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514043FCB0A;
	Fri, 27 Mar 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP2xBRlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81093FB7F0
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633718; cv=none; b=R7k4igJMH122LY8OhUjaG2JADU68YK+HfoEMXXuVUGQhfjWI0nVfD2nyHAffyTjRei2CjEzBj+SeEH53YgJNxSYKpQ+/+VK3M4xQ1PtZThsiIJvmzvzQnSq9o91Xujx8TmZ+kt9G3ikJPoWKJy+oJQWXsQ5gby0Oukn/pLilm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633718; c=relaxed/simple;
	bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=uZu+HQ6UGGIuBtDqQ8dEVKnXdHgb/kNXT/DqKJ+Jeo/9aKWnzOcRgTibg6GHFAX1ZNLSBxCegBxkIWPlAvB+rPNroThpVfBQ4ldI9D3UYiuQMmzU/NVXCnwibJaee0egi7RRCVyWakB9pPTwyMxnQRd0S19urwyYAGsMxli1bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP2xBRlM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a283c44478so2632147e87.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633715; x=1775238515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=ZP2xBRlMHJGZZ7sEvUDuqeo0o6arH3oSL97+mRv1w5NYLE8p2phprtlX4RtmJD2TfT
         rCkBMoYqQloyOKa94qmu20VmPFn9j2PO3n9UFgHnfsPd64Tuk87zszMBfj96VsRqbgqD
         +R8E+GNa/I/Vpj6VCUFkTonYYBvKVeR4Q5c0Et6LHs6TBSDwISkzx7GqsWl+LirP75Hg
         9Rb/MAJx3f216jcpfq9UaLIWCcW1QRClo7/FB3i+heCApYHcBeX34xgBr5g6t8tZBR5H
         kcB57POP1AXVVE+ivRh/iqLus01EMekZOh8YHIdWuMBES57xya0JCCh2riqTCQq/uEhK
         bWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633715; x=1775238515;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llklB1En8Ndzue06w7liksuXHSZughmp9gHG6cT0T9A=;
        b=av63KBXjeZAqCzz0yTmdzGKklfi/SlMHTpPGFDpOBuKfv6tRTgpCLxRpyebUpH28+f
         i3tC/RN9zAYN9ItHtHjXpJvQrkmhpOPRJCqVPEgegyVqZg+RlMIy7Wv2mvwqfIoyDJTc
         aGWyIYvhTFm3ntj5QEp70mhoPtuNWBNVQx7YaFxya5CGi2enn9zbX2qRLYB70KgfOQHj
         jz8zzciopLARHtFx2IHGcnVBHjfbxqZ+Vv51S9unyGhH233dSHFnN4VWfwDnsyTTl4ZE
         jOzEHGCSNGxIy2bCX2zEXUcFqcTp2zvtWV0isn/ryc2GSj5bsEAHL7S0rqtux3orMAL8
         H6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6qrVWhG559B3aCvO4cmgIA0UMrub+cuc+3K4WyYSqivXc1ySftMkyJD2kY4L1RldOeUM4Yic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyR5Z0Cw7kTfhebaAcABGI2MmOStRHSKc3k+qgKQ0cYtLUNfr
	rrH+cCtngKu0gBnZpOTrlB5Vuw18ZUhA2BXDpNOswk8jkX9aBFxILOA=
X-Gm-Gg: ATEYQzyZSTISICe/vgpMbA4GPheTYXdr0fqXk9GWYCXRRm9lIKdZoV8O0Z8C+Tsb0Cz
	Ou7fVcQp6Nt/QdbqGVBjmTpYwXArqTIQ3JmclLvd7VHbT25JNDB78bH0YttGgRPEUjBfeCDwfMQ
	kt4kr8FZLs2m19hPK88Lyh06YZ3wXKahhhaL0dwGt1c/ofeB6QygfxvHldwgU3rUCJM8bwuKJ3r
	CgJgtSgYOk9RK4ajRDSwX5YzTE1FYoEAA6tyu7sStJFkX3JrB55miia0y69wHVQoC2Xbkfl+Rhi
	jX242aJBOv8Xqi5KKi9uz2HKKt9WiRqstW8ahTFYQfKISGRjOVzYgi2Nh/0YuLVCuaR9D3DIEuY
	MntJG59FRD2/6LPk+v1RpMjgC9chcY5rqqwDQvItoVVXcx93EiSVfDFo4cCVFRhxRlRCevwjnM+
	gIgDeh5Wd7ytwES+omnazuBhh6qUx/yVxK/Vwg7CDr4lybRoj8Op/og9BQY3OaQvBSQujOZOv98
	uaGQHZ1/TGYgcKOoExXGd10FJe1G3VK3frBzO+E8hKu
X-Received: by 2002:a05:6512:1088:b0:5a2:a13e:9095 with SMTP id 2adb3069b0e04-5a2ab5ff25emr1603294e87.9.1774633714730;
        Fri, 27 Mar 2026 10:48:34 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a0645116sm1498878e87.21.2026.03.27.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:48:33 -0700 (PDT)
Message-ID: <c4c952a0adbb28e572f2a05fcb317f905fe3f607.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: mani@kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux.dev, john@kernel.doghat.io, 
	joro@8bytes.org, linux-pci@vger.kernel.org, 
	manivannan.sadhasivam@oss.qualcomm.com, robin.murphy@arm.com, 
	stable@vger.kernel.org, sashal@kernel.org
Date: Fri, 27 Mar 2026 18:48:32 +0100
In-Reply-To: <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[bjornforsman@gmail.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230701-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D2433489A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mani,

[CC Sasha Levin as git committer of all the cherry-picks to the LTS
kernels.]

What's the status of the reverts/fixes?

I tested even older LTS kernels (5.15.x and 5.10.x) and they're
affected too. IOW, the only LTS kernel that isn't affected is 6.18.x.

I hope this can be fixed soon.

Best regards,
Bj=C3=B8rn Forsman

