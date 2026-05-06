Return-Path: <stable+bounces-244384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJKrDS8/+2nTYQMAu9opvQ
	(envelope-from <stable+bounces-244384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C04DAD8B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A118B300AED5
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6DD466B58;
	Wed,  6 May 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STgmolnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81813466B5D
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073377; cv=none; b=EAESuaX7CU09Rv7VqVzH4DDI6Cd+pGLl0MDdYPhtuCN7PjrxnRn4pWc9FjM1bdRxJRb7UWKuUPejtulfU8vg6St7stQcZQB2W++0mBlqW8zCxmghD/Ts8fbGQG4yHOBvsS+LAafS9QAS1EmvXfoeTL8pDfi4YCH/ak/b/mL46Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073377; c=relaxed/simple;
	bh=xdp7JO+fSdF3RrNN0w+7CescScNY+i+OM9hNrWuKKqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN0OFaIb0/QqWpDni7DA6fKIPJzNMwKVQDZ5MNVgHKvFEEA20UyGlbkgHNNno3nukf5vx+85hFvKm5teb0RybZZRLEd19C1OxSmAqdl2BEMxrZvxvxhc0rSMQ/M8K88uAT/0PdqwEJzGGpM3m8KBkSqi54NNluUvTsz0+EBrAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgmolnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E4C2BCFB
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073377;
	bh=xdp7JO+fSdF3RrNN0w+7CescScNY+i+OM9hNrWuKKqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=STgmolnRodmEL41fALoTXYNv7Rbsnz+kPv4jFivsERSXI+nM3/MxFo1l5sCfR2Pqv
	 iJBfKfOHTYtlJRSq5tT1vc7QELexQq7xcNiUKBQJILM53duoUiRY5exD+S1S5UzshC
	 Vw58HYyLUwtNdSwTkY804tcVMCPI7Z0qVy/SWzTUq2idM/8zHf22XNy3K2qL9HAB08
	 RAsmHdb92S/2zAED6IO8jiMLS9txHD3Jp1sDsK0vX8a5qB0A77x2HGGlm2mQIoh3fF
	 g44E+EdJIiSPcvffCjWWDST65yrA062MSLcyLX8NfGSqrCq5yNRmvy/nlw7+i++gdz
	 jqti1aCFOe/Dg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393800586aeso10015991fa.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 06:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZUH8sLnZHkUGO39wmD4NYvabMIS7peXlmy3eIwNya8zjc797iTKYN4EUMlIcMMRw1Vvy1eCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5XKWLF343KSxcizipv2Agf+7rmpLYrh0wo02wKSbJOSWbE1c
	/L02biC25wO9WkdnEHLOaoG2u3q5zyDT21M5O7PpWDEQlhC+nnb03W3ETpXkpR1fRrhboXJZXiQ
	BMz0So0X9om1OuNBHG0l7BB2sdCk+fHb0f0odZX1NjQ==
X-Received: by 2002:a05:6512:3d04:b0:5a8:6f3d:6cfd with SMTP id
 2adb3069b0e04-5a87e66e8d0mr2759547e87.1.1778073375835; Wed, 06 May 2026
 06:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com> <afs93y7nW_VTc1Y5@ashevche-desk.local>
In-Reply-To: <afs93y7nW_VTc1Y5@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 6 May 2026 15:16:03 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeFCyi7aOcyEcaiwWa_vxLxXD1Y_6LsO2R8K6AfrxzHQg@mail.gmail.com>
X-Gm-Features: AVHnY4JMmI4Fy_4mOeAD3iaBKBIc2zSpCdsRhmEz73_REvV7NEjtzeTHbh_DXYw
Message-ID: <CAMRc=MeFCyi7aOcyEcaiwWa_vxLxXD1Y_6LsO2R8K6AfrxzHQg@mail.gmail.com>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E93C04DAD8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244384-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, May 6, 2026 at 3:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 06, 2026 at 01:57:00PM +0200, Bartosz Golaszewski wrote:
> > If a firmware node is allocated on the stack (for instance: temporary
> > software node whose life-time we control) or on the heap - but using a
> > non-zeroing allocation function - and initialized using fwnode_init(),
> > its secondary pointer will contain uninitalized memory which likely wil=
l
> > be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> > example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> > initialization.
>
> Hmm... Are you going to use that outside of fw_devlink?
>
> The patch itself looks good to me, but I'm not sure I understand how it's
> related to all the work you are doing WRT fwnode core implementation.
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> But Saravana is the best person to actually tell if this patch makes sens=
e.
>

I just stumbled upon this crash working on adding support for
fw_devlink for software nodes. I figured it makes sense fixing it even
if we have never hit it before.

Bart

