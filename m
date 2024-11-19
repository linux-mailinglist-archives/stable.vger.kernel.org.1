Return-Path: <stable+bounces-94035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97489D28A6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2E9B24726
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA891CEE91;
	Tue, 19 Nov 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="b+yqNkfb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D21CDFD8
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028087; cv=none; b=hhdsZ4frNxcJ9cwLgLZGrBp2BLbTzjfqXqafI3b4XmBhPwsnTmUbtfDNA48Y9iJY68XlVkPSxHBewUl8KhcTjrOmERPbgn9/kFkkgJEge9mkhFFo2xbjB1Xpflx/zUHYAA+6i3SChikMFBkXw8QuNbEQDDltcojiffXQCEVTesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028087; c=relaxed/simple;
	bh=y+k4CazNvujMU74lD4Cw4HxpVoXKoadx5aTCGAmeTkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6hqsMmAkiWeyTB1CK9GK6aWJsDCOZ4phCC3786zT8n+hUOhoSF9o/lQlNVljfuxCrvnN+A+OYXgp3EnRWhjBXHHOh4SnUhGGBkDKE81JQqYmw+BUXljuoR8paWoZYPJ0FUWKwpUjnOUy2zFx6FRs6d6dxJ9+7TzofDLoytLqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=b+yqNkfb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38246333e12so2385108f8f.1
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732028083; x=1732632883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+k4CazNvujMU74lD4Cw4HxpVoXKoadx5aTCGAmeTkM=;
        b=b+yqNkfbNcJQHjYcXNoYzMC1hEX85s8+z1LTawIM8BFN8ZSMwtTI9QaDIBTEvCCS7n
         +OAMCXNX0fPxyPxonavP7X5Ql6vR2cIplgQKZc/cmgqJj0O7pHJ4KYqXtj/jLiJTogo3
         dK8P3WlsZOfVyMhqOnGYJh8xGNIKml18btYloerTEn6zicuunbIS5WOEGPKKsfug0xz7
         QyVxih0JMhnhGKxEbwJ5aKxlyHJSCk6oS/kHdMznsrVVYgsb+YsrPcxiC98Jy/17Dcos
         lSQZl202Y0zLCVHh/O6N6vSC6/C5Lymbn4lOAKYzZWj4pRJbAoC1YWXf84QNPu5A0RJI
         z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028083; x=1732632883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+k4CazNvujMU74lD4Cw4HxpVoXKoadx5aTCGAmeTkM=;
        b=ZNMW94TPUW6AtBZBti4ijBLBnXouF5lByDwBuu2ih8HnNGfuQ2Ehr0KKgNuQUUaZeP
         470OhRO5VymtK0sJJEdGtiFIi9gYR8FeC+Xi5OaNiy+dBgTI8H3abDKVazvEKCTD6C14
         Ma2azvOlejZRQ2uF+zpKa3hHLoylg9+lmRjbC8V6aQQc3cOCa5gOPVAg6ycm3aQB+zVp
         kGE1ok2G3uSBXAbrf28XNiZq4Bfk0UPKQ1q5q6s5O76jnvtdg6LSt0cWefdpzTxDdL3l
         QF/Rq9A9XCd44jeQ7rAZHum3Cg4gIb0N9j5izOU3odiADsEsQ4sHZBTP/XA8VY0fvnBL
         USOw==
X-Forwarded-Encrypted: i=1; AJvYcCXbqvMTg56UBssC1T2MWQ5l4Vb0eKyp2P6000KlnJ2LRWwTsGX115zv18JHjRk2pBPXNjofmlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzupyyre4sj2S9xNfs1F8bV3aKPRG+JEDfjmAfN9rptIOeXw5wL
	oPyldjYWIw3c6xRopW4gAOsAGAziE8Bp74DuCWl3khsohoFr8SqROMyg7p+8BJhjeUbbgISMvJL
	KgSeKV3a4MJbrH/L4CmWFzWqbP25xNTMDGEuwgw==
X-Google-Smtp-Source: AGHT+IGuKk4gG4vY2G6qz9afVz/KqkacpJNrLmnb5kFxR695mDP43aiJMoLRGZeY1f8uPQkmwuJwMCBH3Th+igQwxWI=
X-Received: by 2002:a05:6000:144d:b0:382:440e:4e88 with SMTP id
 ffacd0b85a97d-382440e521bmr10076471f8f.16.1732028083591; Tue, 19 Nov 2024
 06:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com> <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
In-Reply-To: <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 19 Nov 2024 15:54:32 +0100
Message-ID: <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dario@cure53.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:58=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
> The protocol does **not** require building the full path for most
> operations unless it involves a snapshot.

We don't use Ceph snapshots, but before today's emergency update, we
could shoot down an arbitrary server with a single (unprivileged)
system call using this vulnerability.

I'm not sure what your point is, but this vulnerability exists, it
works without snapshots and we think it's serious.

