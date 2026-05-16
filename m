Return-Path: <stable+bounces-248995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MY7HjZNCGpqigMAu9opvQ
	(envelope-from <stable+bounces-248995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:55:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5155B3B2
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A10C3013A44
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEF3D45CB;
	Sat, 16 May 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsZq6v7d"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26835AC13
	for <stable@vger.kernel.org>; Sat, 16 May 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928941; cv=pass; b=ZRM7Uly5g8L7pZXchCKspwjAzHlhVs3tJ83qfoAGQSv/xWUgKKRzQh+muzkqoy93t9qD0Z8tJBNCvqlVdGlNNa/3lQreQrOcuomuyM6XzwlweNqQj1ze0jX3mQ5KawrEQ7DT8DKHjK6UURODGvChwXvCPqD4fTvA0kahFhVFISg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928941; c=relaxed/simple;
	bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxp2xPeEiWgTZY/LqS/Py+9Ays1xRvbB5JrD8hpc4aES8vsO/CMidAa8B2pEft+9ccLFQEW93srwnJkSke0k9qGfGa30gAPp+73FLzDyM6cByyYjjSSo6k2K6S+1KPUjrbcO3tymNy2229PtoQLX6cDsVBQOQnEDcik+ZCPSZF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsZq6v7d; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c58e6eb3edso2340447b3.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778928938; cv=none;
        d=google.com; s=arc-20240605;
        b=IP3CjBK8yP/0StZbALTMC5skIDtPwH8v2EFVBgQNJ0W5TK2e7Ae7yoN0k29F7ZOJSg
         GiwfHn6Gb112Be9YT8TmpYgg/yaIrEDrVlDdqpK7+qAhriV6dBBGw5eROuZ7pPMxGYYa
         eF5EDwqx7F3D1HfKfsESTKRkgZ8IpvpHNS5lVHanKIKlHATqLeKI83tDISSb9k/Aap1L
         P72V6dyEXS99ME7cd9IfiY9bGA14Al2nD25PcWfSH/yFAx9v4I0YJpQG/uPJSk14kZqf
         KWcUHOYgkiEm6Ktn1WZg5aTaUmM4QwaEo/KnIz5FV+YC818osHCW/YK6hcU+gKyLyKl2
         BgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        fh=jHsJVZteFHT2nGuefDHwfd3dZdAHdWOIRfhxvM1lSFA=;
        b=RfDvx/uEV2VBttDqWUVquN1i6FrOZsyHrERg2xsuMPsaJrNZU7oF0bYpDqVUCrp/Xz
         8B7ytVSZVEUPdp3BIba3LqUIqZQmSTzi4BDYc9FsZydikhgraREVTNohljCx5WSEo4wf
         R9Xj9qdtTdCnn9OBHRG/H0ifzC4J5BJDdgAFcL44CklBudBlLf8mKokOV5FHQvtXpp6k
         R8AWCEUMAXF/5rmUOQYV3gD++cwlPczhMH10RoU5B6agJI3sHYz5xNc55bTkwSkFTpSo
         mAnqiYmv1R5sxSV8DrGtcLoHZPaZ/AX4q8/e2k5a/idTaAf3lFXMMhsDNMsNoEYAWMJr
         UIdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778928938; x=1779533738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        b=GsZq6v7dZDcbSi8fd9eExCz0xZgbsKrPjDRcniLyr2qYMIeOc/shZVvAEaTFUeU9bG
         6dElielVZdZcfxecQYfz1D8rqKLXz2jLZB26AYnzRBY2TgrIjqDaAC8Y8I41Ggb3CQtq
         c9GWpK/8R/ywGIJ+QyLh/ttGTtOVLQA6fBghH/lXJzSrJP/rNDwyoDnULRuswKer3EOU
         rSXUHhEFMPeSdic6k0ivYqclBmNruqWfQU31rfq0QmZ6CcGCWSx1fNC4HBUmJtZfkvM2
         xrG1ihBNZot52uy8gaTwCLV6cHPPk92oBuW370lnEY9OVtHc4DpMNBIfvnhUfBCekTXR
         P4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778928938; x=1779533738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJm0Vha4QgPi+LutZgf6PJHq7Sc8qU5QzD/hNhrZv3Y=;
        b=o5JNg12KjIqE12r+2HGWAyeFWTjwfBeXv/u12C/+HcYIc9Ps1M8FqpSg0+8XIhd+tU
         wfRft9yan1s7iRKTZhMQTmFfbYw0wvpSJU9/ChjslyC4jPNAyWkhpeGJUA+cLGaYPeZS
         ZnzHylF9oMF/pSnHcCE+HJwiwIAJj5QMqBm75fGXAZEcdsMP3h66ipUXxuF1mxHRaUT4
         yBGomC8qIsSjrLT6wOAwQUWHd6YRSdJ2wRy9NfemfCCTGerboBvxqgDGIQ3p5hB0BAQN
         fLaBRZJhsPj67LVOR7hbfDe7+qlLZZWw3ioQqcbs4lkSIj57vTnx5605u+NJQ9pRgKTH
         vW2g==
X-Forwarded-Encrypted: i=1; AFNElJ9PAl0PJ36zBlTN2x5TXGPePI0K5qvdNQ7S2L+Hs+6p6liMqWtsQAAkwACQyL9dDeGKhJ8nNPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgYo5gojQhkcTJSQl2YriMpLAyt9g3YOv2PNGxr89DIabc6Ks
	OZ0MurMfZHCRPYprmNhAIVAcwDfsaQX+rydGL8FgL427u803KQUfG7gIw/86sQn/8WW3PKMOLh4
	Mc1LYqvWrdIYYQ9gYKVijhvWArz+sUrs=
X-Gm-Gg: Acq92OFMKLNjOa/dLCZYXmKF+hZSDnev73qFrZAxZmTAVkLneLgbU92VemST2T8Bgsr
	GBUjSwonzLTvHQLxu6PpWist4g3mz+PpbQ50/YSK07Wehi75PvVfKfMxJatHn/oFkPK4fPu79/s
	bJ7b2qj+VTMhlJqEj1eXiN5E60Apd0tUrrrHms6/sapye57TBVJ/A2TuVKnNUSu5cjv/3uRnCnS
	c+jRQFqE6P+jvMlyew7QoBABxfazxqfi3EfwgvEaHyBOKk/zLF809uD9dPwMlX2GM+RU5q06ped
	cbEelCs=
X-Received: by 2002:a05:690c:22c1:b0:7bd:95d1:ed51 with SMTP id
 00721157ae682-7c95b829b37mr88157687b3.28.1778928938365; Sat, 16 May 2026
 03:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87se8mytvv.fsf@toke.dk> <20260512144512.9960-1-bernard.f6bvp@gmail.com>
 <20260512163648.7367a640@kernel.org> <CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
 <20260515181411.28af7ffc@kernel.org>
In-Reply-To: <20260515181411.28af7ffc@kernel.org>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Sat, 16 May 2026 12:55:27 +0200
X-Gm-Features: AVHnY4LM44c5zj8zy_QkFpcfHYCBiRpHUh4S3nKYrYR_oB3folOtDOnJ-b_4rwg
Message-ID: <CAFAa3YCx0schCKn8k-nPfQPSaQ_5PKYFzt-5j-ZyEZbKr2DyuA@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: kuba@kernel.org
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D4B5155B3B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248995-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

1. rose: build with hamradio_compat.h on pre-7.0 kernels
(compat shim for struct sockaddr_unsized, required by af_rose.c)
2. rose: fix dev_put() leak in rose_loopback_timer()
3. rose: hold loopback neighbour reference across timer callback
4. rose: fix race between loopback timer and module removal
5. rose: clear neighbour pointer after rose_neigh_put() in state machines
6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP

On Sat, May 16, 2026 03:14 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 May 2026 16:52:43 +0200 Bernard Pidoux wrote:
> > I am happy to submit these two fixes as patches to mod-orphan if that
> > is the right approach. Please let me know.
>
> It's a GitHub repo so PR is probably appropriate there.

