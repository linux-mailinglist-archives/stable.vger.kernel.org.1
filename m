Return-Path: <stable+bounces-256650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIlwGyLAGWpJywgAu9opvQ
	(envelope-from <stable+bounces-256650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:34:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01F605B5F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E5230557EB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6BE3C4B9A;
	Fri, 29 May 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UL5GvWG7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9D3C3442
	for <stable@vger.kernel.org>; Fri, 29 May 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069550; cv=pass; b=AHbNaAF0dYBB5KtDI1rVummcOn9hiJ2Tm7lljEqUKJbE+CPvQC/9lkIlejkyrD8Dcc5x8mtOjlO+CcQWZIMKmilLT/VM6V6nY3zQFi3uzUo+HFDmK+s3X1zJ2N53MwKcliS3arMmXs6+Xp5VvRnbnCEKfv9IwxG7o0l05KNK1js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069550; c=relaxed/simple;
	bh=1hMieIIxqcU89DUFDk9X5WdEWgHHTxNRY3vF1kpWUpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS5gWgp6xNRP71XrUFyXpjM13xfFxyrr7zoSJ6KHGG7r4yGSFgMii8pvHopwxDdp0aDyX7J1cXpksKFEcg03F0yLSaPNO/5SRvC2lY5wy83XP1+ChWn1+yNHviERVRPJ++bDaKzGJokE8CPXuOMVcqql+Auk1gyAgDjVhT6yClg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UL5GvWG7; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb05b1875so7351897f8f.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 08:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069548; cv=none;
        d=google.com; s=arc-20240605;
        b=OQ2aempeEu4uaZc5K79K468EGfdVzVYMTN101se52bZdMTHqPiVrU5wfYgBAJoQcTA
         tT+RRXKhnHE8uypk7qesBI+3rf4EfBipMIaPUAanI7fCajZZDOk8VCG9M9SNsw1W1b4N
         M3lx3t+v9/XbyQ38lcJQJY7OdnQkC4LoDJ579NQdNhGghDXR094K8xDEJ3cl6TTtnODG
         YOkX9PhOnutYh9+IuXM9JHvbzuLISPJcBOOw6dALoKoiYtSu0ChK4/AMX7ruQzt8ObEe
         dDBh1KTr3hab9K6Th0GQeSxGMNyPLWxmjx604Y5iU8ohIWuDRJv35GRsogHmSmb4Pdud
         Nrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1hMieIIxqcU89DUFDk9X5WdEWgHHTxNRY3vF1kpWUpw=;
        fh=b6SkgeTKxHdI/IeUubK+t9Uw+P+Vrh1Qqc1j8uCorr8=;
        b=Stj2arQ5lnzdNUWx4sOXZqHZbrWhkRy+vahdIVg77HowW9QQpaoai+9QC5gYb9nqqr
         2hrm4rPpId/LuzM680gMHeQpUpQIDxfNzwTKrQyKJjWcPVoThD3G1eynovAE2Kq6SlAt
         t27UW4iAAdGmf3TCu7IX2LPzZYFjNN2aD+rpFWBuVncRCalED1cl3mamj0iIgQRQ1oY9
         fnehAyoprvkcjjRcElD4yzZPjEFTiZ/IemRQxRB/V/raNJENc9PZeYqOF989+tvnb/nN
         pdcCmUdau21lHAiyvWmUMmgkgLbe+ENoKxhaEPjYldGy+LRIM6+ceiH+50BgamHgRkDX
         666A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780069548; x=1780674348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hMieIIxqcU89DUFDk9X5WdEWgHHTxNRY3vF1kpWUpw=;
        b=UL5GvWG7i9T+kcu+kqa8cCgBSMFyo41yP/KZq4qI7J/oE7zNLPUYJf3xfR1GJk7Oyb
         y3Nm14zS7WF/4Ih/LYYWiwJk+ZxPyKNsIk+rkbiU2ZGcYyRVUPYXJVvZKm9MwFbgwzyr
         8qCm/rrGQKKa2gLzA/F+6xAeyx/Whjj5lSkSRXMGGXdyYOcO8b+2omr7FWXJ1xY5D6Nx
         FwYqhdSQq7vnBDx3GGhLXXkBHHpJvbE0HL825GSI6T3Up6fW8TDuPH41roz4nRuxSWWl
         +Rc8KLMOc93d7DS/43IZSM3MhjiSxzB4sFK5SE4W0oHhIpSOX1ZPBw1HVs80YTNr8gLd
         lqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069548; x=1780674348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hMieIIxqcU89DUFDk9X5WdEWgHHTxNRY3vF1kpWUpw=;
        b=F8M2ujcgkSVLSngnMMdr7l1jfT6VJMMIjSibE6xYNM+TkaPI3PaquuvBCr9dVFd1zg
         pIwlCUvD+l7JNKMJYrRPgP5sonj/NW2q3stIXRkyPomT6m0HqIqkUanV8X6lcKmFGoG4
         Jg7zvzi1FbASnEpACwA2ziXJrXkbWxWmdyfPvhyv14ZgBDMgiDou7W7W2OiwNk+iX5EL
         vZ89Fe4nUL2YE37fBpMt7a9TUw8m9hy7GYGLz+f8TwkxmOJg/FC7Op7/Ar+Fudo/Odxw
         UuB8YCQBWiwP/zJLwT59dc13UElXuLeFBRBHoOGCvto8pKZKG9H7HMT61C1cdiUk4pMt
         V3fg==
X-Forwarded-Encrypted: i=1; AFNElJ9GiiUoPY2b636sSgkkH/5StfSLsWYnr9LLog8rFUQcYnV2kvEKVGVCwv9xXhm4bA3DaP4J5gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FLTJbKbb2KHRX/Es8wWEGV2MQ4lI23bUT7qZtA1IxCilV0r6
	DPwo4sNpn3HmDpnQ4xFTDJwGpiRE8Jv5ph34EZ08QAfF4PfJ52TeEyqAR2R/GvDz3fYEabQ5DtN
	d1ZfCHYAf5T52fjpt2Gk1rYxI+YrTHF4e4JO4wiOuDg==
X-Gm-Gg: Acq92OGsiShO2y3Yq258hL8FPzUnLe4KQ5prdowGWQJhH9IzgMeJ85nbTzQ7gv3aSjP
	NP4a8Z5N3Mjtu2e5845vYI/xlv5PDuJ5KiAiD1BIeQ4sFw6VkwTo0JDSc69HFjcav99DQss6yor
	vjjONsqmFNEDQCcQmMUUnwB7KgxTYmYIe9mSrfsS4qnEn9+kUABJB8QTQnq+G2UIQs8DaPycPwB
	+kZEViYjupPghvMYNVZGR14+qMBN+HZv3EVNbC6Qezu7ayngLlDYuSSxBQAmgwKFkLQVEMARdA9
	Ptn2BXjOidPRDE9N33d4WxknXMxweh1pV6rogHsmVhiOogI2zhZ2bTlDtEMmK0gY9vkQGmNbhH/
	XGmfWAgbqoG3/PDs=
X-Received: by 2002:a5d:6e89:0:b0:45e:a0ab:8bd1 with SMTP id
 ffacd0b85a97d-45ef6af783emr544721f8f.7.1780069547846; Fri, 29 May 2026
 08:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194638.371537336@linuxfoundation.org> <20260528194647.015775177@linuxfoundation.org>
 <CAPjX3Ff-a8JHxeMr1Hk83BmQX9YLGNR+g+7waygn43ZD7pWMHg@mail.gmail.com> <20260529120000.btrfs-inolookup-keep@kernel.org>
In-Reply-To: <20260529120000.btrfs-inolookup-keep@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 29 May 2026 17:45:36 +0200
X-Gm-Features: AVHnY4KdAWpYm2FShY6ZN8oR0VRdT_3F7I0pxlt6c9pg_DFkco-beqT3hh1-SlY
Message-ID: <CAPjX3FdGqfvAW=Uj70bg9PKngBQOUypMz9wZgwwsUKspRJTxKQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 299/377] btrfs: dont search back for dir inode item
 in INO_LOOKUP_USER
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256650-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: DF01F605B5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 at 14:44, Sasha Levin <sashal@kernel.org> wrote:
> On Fri, May 29, 2026 at 08:39:10AM +0200, Daniel Vacek wrote:
> > This is not a bugfix, rather, it is a cleanup.
> > Even though it's kinda small and limited to a single function, I'm not
> > sure it's worth the stable backport.
> > Is there any specific reason you picked this patch?
>
> You're right that it's a cleanup on its own. It wasn't selected as a
> standalone backport - it was pulled in as a dependency (it carries
> Stable-dep-of: 1e92637722ae "btrfs: check for subvolume before deleting
> squota qgroup") so that the squota qgroup fix applies cleanly.

Nah, right. My bad, I missed that. Sorry about the noise.

--nX

> --
> Thanks,
> Sasha

