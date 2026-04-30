Return-Path: <stable+bounces-242103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APVuFMhU82mLzgEAu9opvQ
	(envelope-from <stable+bounces-242103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD764A3313
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26F6330269CB
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617140629C;
	Thu, 30 Apr 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stXel95H"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C4282F04
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554561; cv=pass; b=G9uFzcgJHxrZcAchiHTn5WAeITKV8leH5MWDaE6Hs/fCojwZXvAJFSI2W68YOVuiDAfFRL2+Jkl2DbFi/Q1A4e+BvKXLHl8U0gQPEIz9+JrkUY5DQB5ngCoYW+S1rcZ7UvoD5Q91fenuNzcJIToGwTPmN1vGEoWutoChR/+MNBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554561; c=relaxed/simple;
	bh=NQqTciBzAout6/mA0tuAlDcPMajVgI8FJzXVI3KSEAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETzo7Lu9VezWujJTu83N6mn/x/IM+sLscGsimXkJtWKK99s+EOL2r6Is1IEIgzxbZ49EUUPxEaUXaNjPAwJbDP5ttdHN00AEAemJUybNWqhOFAJZMieBp6KG7ZmNofbNoFSwv9GNyefDuyFgpcChgFivV6mj/Trhgs0q786k8eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stXel95H; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso1267149eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554559; cv=none;
        d=google.com; s=arc-20240605;
        b=FMYuJk9ndynNGN7f+w8L8Xm+AH6FhKSrU+9CLqj/s5k0o4CnUHbPuKSICGueuHdGWH
         7CF+5tCynIQv/gMbbsduhKOh8K6zwdvaIPgWjBGZ/CWYplIJHPwj37i+7A0/E3JOwOKn
         FroGCDVg6rt2CPbeR6oApm/s7LeB6CDnJ1O663CzS+1TkxQ0ZYPIAQtIS5DuANXFlfeZ
         yHyVz+JuVpTORZXqsk+8ChmxPtnEuc0PlGox6kAGsbjzt3ZL0XRbzoXXZjzHiv+xS+rD
         MbLzyTIhNkc5/OFaIjMg2FYX68gza08O/353thgjr5WawtI1byVRCjkE1BJQ305WActD
         EDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3svo8D5AXO6GbJ1b+UfLzbE0Oh+IGpo4a1Axx/VmTCA=;
        fh=Q16IFrHcEn3zHYnczrr9W+hcJOt0NbvTZHWSvV8Wqck=;
        b=LYDAOzkHhQ2SpBPZvRZxwaApyUvK3HHT4fnab1Xz+o7bbx0CCE21671/C4E3DEijZt
         HhoYCZbWJy63WSS69kad6KeFy4+NBwRH2cukVk8AN/SZhipPWX0jsFIK+0Fa7cFoj0ZR
         pwvuDdh9TNk1JdcJrzulpSkaOhvDLX6R2qyb+Yfi9D0MawRa+TJGdrUGfPJsJaxmdBN7
         yQ96mv3xhlmhThgqZgCLEyMTdmBnqdpuhqXl7wrhEki6YpWT26u5h3jQtGk5Dia7fGmY
         uw3Ds9YTx5d2N3qFxSHSVLBs8+sDOFGiAQKLMS/ZckAWe1eTJkmU2HfJZoJ3bXnQCSF6
         ygjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777554559; x=1778159359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3svo8D5AXO6GbJ1b+UfLzbE0Oh+IGpo4a1Axx/VmTCA=;
        b=stXel95HvYT8ojM7AxsMJqjPoJBZC/hFDs+joZeRa7EgIM63xs9BMv/cn5b2voCssN
         +5WKvj/GpHluoQZYXzpMNiZptKTgHvCZ9CJ9A5H0vbnBJdVQOcsWKTtUG/CZdxGITrLq
         6zpcgPDz+C43kzsw+Em9jGnXwxByG1EtGPBEryg5bTap84hFbK4cIm+t1MI4u2d0yo6v
         r18cS1fpNu5OEQz30B35V0yqLntidzNc7oL8k+hOBYyyz69iwH8loBBjmaVLHeXNCDhS
         zu5x6Ief1JNaI0LJ3v1rJ7ffFC3z5hxXl0qEPB61hEcdNTmSjfo2UK7kozx5z818MMAa
         T8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554559; x=1778159359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3svo8D5AXO6GbJ1b+UfLzbE0Oh+IGpo4a1Axx/VmTCA=;
        b=s1JohYk7UrI3pxzKIevPuDRJQnFZJeqLpjs3CCydm7+56lTP/pQV4Na2GhnZ0J5pu+
         PtdvoT+W+UPQykdk4/wwAd7a8m08TbIhjWX4uYSMgOSnTatGZHidRKUG2xewGo5qYGUC
         vQEKUQwBu4Pru1kAk2B4aTr7t1UWdfQcILbcQBtMGXUSnBYxsvfJYZlpfDJh9YO7n3Mg
         qUN4i6gU4XAqV3HbnUltyv6I4j5FImsEG/hCL+fT3xThewsAgn16VAqqocVOp8yDX4BN
         bV9FrJ50EQP11Y1/bZlD71V5mt11f1huga662HT9du/C7B1qfuYE85pUKgEijqDzN+cH
         corw==
X-Forwarded-Encrypted: i=1; AFNElJ+D1OY6V4FcMXAUG+iTN7gE9itNcrSl/wB9r8LO+meDRN95FvZYiL/GCdVaO/Xf2vCC8bWEmAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLtxleJU+kYnQH26hHhrHn8uuG8yGLhXFPzbN8bOWvjgncGSC
	eA8rWVM2QFQpcrly8nYhZS+WvAGiPkIyCU+jWghVc6VK2FaTjDQF+Aelb0EaM5DUfzN1IaHXq4r
	91eicOfrLephKDM3Qn3zDSrBl8Mif2Jw=
X-Gm-Gg: AeBDies4iVJ/Q7A3YYvybXVLwRAIT9UItC+qyZzARsGLfDLGhQ7KrQhLGc7Ox+E1j9S
	quzsnRFV9nTBgQEqm5hSzNKIAkq2uHO1sUWoANW58bqkXDWrU/uKNqYS72a3LSst7OrX1GJ1ivZ
	gG3LCJOoA4zXCPYZ9ZHXAaoYXMYXePizBGnSb5wuzLnpBlY+BYw/ITMrWNX3YFyj2BHM6tLEoso
	fEf6QDDJIKGQJEOA/w7AXBcXmUyKgRySRqyVdcLsZ+VIPbx/uTdx/4xaY4A1DnRZEiWeBzM3QzO
	uEH/5fnx/p8jmxViTfpspVaOuQYzsyeRCyHHIL4iObGz30Q8jcoVCUeP2Sark1l5ybMsSRuCsbg
	pmgMN5GUTztz3TsXeWzrcyMZyspnpzU9W6qb4b6cxdBeyAc3LGjJPZLHryQ+efYMvQIMSZMlikM
	9nNYliDj2TNxb37JWU9OsIvyKbnymLzDjjUPWDXmevCSfItTaaRMhzwpDJmqw=
X-Received: by 2002:a05:7300:e125:b0:2d3:f3fc:bb6b with SMTP id
 5a478bee46e88-2ed3ced0a7cmr1300447eec.1.1777554559126; Thu, 30 Apr 2026
 06:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026043052-coasting-tinwork-27b5@gregkh>
In-Reply-To: <2026043052-coasting-tinwork-27b5@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 30 Apr 2026 15:09:05 +0200
X-Gm-Features: AVHnY4Kgjh8JwiOKygWvOzRxmfaTgSiqUA14yJC3SVv0G73y6203C-tutGBXz0c
Message-ID: <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
Subject: Re: Linux 7.0.3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: ADD764A3313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242103-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,copy.fail:url]

Hey!

Works fine

patching: https://copy.fail/ next ? ;)

Den tors 30 apr. 2026 kl 11:51 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> I'm announcing the release of the 7.0.3 kernel.
>
> Only users of Xen in the 7.0 kernel series must upgrade.
>
> The updated 7.0.y git tree can be found at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
> and can be browsed at the normal kernel.org git web browser:
>         https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>
> thanks,
>
> greg k-h
>
> ------------
>
>  Makefile                     |    2 +-
>  drivers/xen/privcmd.c        |    7 +++++++
>  drivers/xen/sys-hypervisor.c |    8 ++++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> Greg Kroah-Hartman (1):
>       Linux 7.0.3
>
> Juergen Gross (2):
>       Buffer overflow in drivers/xen/sys-hypervisor.c
>       xen/privcmd: fix double free via VMA splitting
>
>

