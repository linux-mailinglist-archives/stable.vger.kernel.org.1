Return-Path: <stable+bounces-253759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKmgN702EGoaVAYAu9opvQ
	(envelope-from <stable+bounces-253759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:58:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CD5B2987
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F14CD300F74F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171C3D5C3A;
	Fri, 22 May 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7cjX7ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36063D4131
	for <stable@vger.kernel.org>; Fri, 22 May 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447407; cv=none; b=JVd8QMInHvmgxxBqU2T+qZWdUFBQS/bIpMSV471nFKc3FrN6Iq6TR7TCnm3duxcK3kiwxt1NKHW5ZSJDQvyIrt65LdkuEmNGadFfmm6h/5KNa9ANHJzh9JRBturs6IsSX6eFAJDIY52pJvsxmW3bmhkI2fuu4HWWAcA+WsygRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447407; c=relaxed/simple;
	bh=IplJtbl/QldYTz6VRXsIkthKDuMKnQtV4ggd55jk5LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuIKE3RPIM5UOlBZ55iSJ9YaUwqV8rz8kyf1z6wrue4Ra8pMDp9yZspqzpYvCm6LP2zxj0Qg5cyD8rsb+1akzBZLiDt9ZUDknLNB7LnX8p1Lzf824wVLLarEAJ2uH2yYHBw7ivJjzw3hUe9tSOZmCv9F81Y4ZLIB/fwVofAcOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7cjX7ay; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC5D1F00ADF
	for <stable@vger.kernel.org>; Fri, 22 May 2026 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779447406;
	bh=IplJtbl/QldYTz6VRXsIkthKDuMKnQtV4ggd55jk5LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T7cjX7ay+IjCo/XvaXXaL/4uoUBZOhZifB2I962uL148es7f5VNeXtmJYl74Y8Tnf
	 LHsrTq+/wUWMGrp7sE0R1xTJ0T5vVVO7FQl0Mj95KgV9vZ7SeWxTez/7ft8uU4t569
	 4jp1QHxQ493MWIAG1eHnb7uJtghdxHilu/r4nFpLK1saXx5ov+F2eQTj7DVQ5p/XiD
	 PrIjm6W6DZaENehgd2IEPDIL+/+/PvRR1SbxQWi67rOnjwmeAyS810VcMnFwPBZHzW
	 Z3SiozJGJZtAwPGkfvgiPXZzuFWtk3+nDXSJ64+G7KuvARAPKKfLBI1+dl5Z/Ldpe4
	 g0GtK3nxCnMig==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-393c40246afso82637451fa.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 03:56:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/A8Z0Hfs7vrivg2aKdhzCP3bkeiEkJDiNQu+msv/ZLEQG+4x/pm8MZFLP8nz7KD3Io79G4Aww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTzEyR/7/6VHm7597g+kDGzRGJY5apVZBQJnh0St6am158JyC
	zIbCaAhQTnrwA4hoVKnRGkVsdSNp/YuIKHoN4Uey6Ou2lW9Vz24mRlAZ8/0pdNWVudTNhIoC6Hx
	/ywhN70VF1LiGwGJxp2KvHTJMGMSV6JJ4rSDwS+yV2A==
X-Received: by 2002:a05:651c:154e:b0:393:903c:2262 with SMTP id
 38308e7fff4ca-395d89a4254mr10396261fa.15.1779447405284; Fri, 22 May 2026
 03:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
 <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org> <2026052254-rug-mug-24cd@gregkh>
 <3888011e-789a-40e9-b222-c5522a6b7037@kernel.org> <1ee68533-144c-42f2-94c8-d6ef7c1dc644@kernel.org>
 <2026052215-motto-cartridge-1370@gregkh>
In-Reply-To: <2026052215-motto-cartridge-1370@gregkh>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 22 May 2026 12:56:32 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mf4onnNjRTdHJjC_pvXWfTe-etp-uHioqU_FXFUazomTg@mail.gmail.com>
X-Gm-Features: AVHnY4K3KnsfdOfeuEzcRWhkfakIzGSm1td1H6CfzALrBO5gFUHUDx-sf6Vm7QA
Message-ID: <CAMRc=Mf4onnNjRTdHJjC_pvXWfTe-etp-uHioqU_FXFUazomTg@mail.gmail.com>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253759-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A85CD5B2987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 12:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 22, 2026 at 12:43:00PM +0200, Danilo Krummrich wrote:
> > On 5/22/26 12:40 PM, Danilo Krummrich wrote:
> > > On 5/22/26 12:24 PM, Greg Kroah-Hartman wrote:
> > >> Sure, but for now I'll go take this one.
> > > The follow-up commit 7eba000621ff ("device property: initialize the r=
emaining
> > > fields of fwnode_handle in fwnode_init()") is already in driver-core-=
next.
> >
> > s/follow-up/v2/
> >
> > https://lore.kernel.org/all/20260511074927.9473-1-bartosz.golaszewski@o=
ss.qualcomm.com/
> >
>
> Ugh, ok, we will have a merge conflict, but at least the bugfix will
> propagate to stable trees :)
>
> thanks,
>
> greg "digging out from a huge email backlog" k-h

There's no need for you to queue this one, the v2 Danilo linked
contains this change and some more hardening on top for consistency.

Bart

