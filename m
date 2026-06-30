Return-Path: <stable+bounces-269985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EXOBA+vSQ2pFjgoAu9opvQ
	(envelope-from <stable+bounces-269985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:30:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FEE6E5717
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:30:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZqIWd7A7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269985-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269985-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA2BE30485C2
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292C413245;
	Tue, 30 Jun 2026 14:24:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5423D297
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:24:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829488; cv=none; b=m6D6IQODAB47cryvqtXcRH4HtWgwBAwhiXgJi0S2g/Hz2AwmCOV2uA8fSiSggDS5kFEtwM8Sbf1AeQI9SwGvf4vZu6GFoPR38jPipmcGYslyq0e83juCN60WFNlufapy092XmDrPxAP8kLfQKu2VL2kjRzHjBHwZS3QdLWyoKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829488; c=relaxed/simple;
	bh=ttHNQJ6LLPbp8LlZzsGWR60+yvCIT3w/tlx6dnEyYG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqGqMYLWd5KJY8ol/a1mXqqIrPm9xKENRPwrxA9Xj955VGWdLyGW62emwKjb1KB/mY934lZqTRckcOhMWYXC/IhTeB0zkC6KvcjyOSTOwJGK1vCyffY7Z+ob8LUnCyEvZBmRGAZK/s/z+3Xpblcb5Mg5UeF8MItBLicbYU99XRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqIWd7A7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DBF1F00A3F
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829486;
	bh=ttHNQJ6LLPbp8LlZzsGWR60+yvCIT3w/tlx6dnEyYG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZqIWd7A7DwQLPR8w68uGyXLFWyEXmpuzXrk7GapQLZ7Pf4tKR1cKzjs1U3ENFFTxK
	 YT/vFOIlPnjnGCTqp7qMlgprCb1+FPV83ty5Vyi7Qhs8t3FusqWTNXqMlY5U3hUCPm
	 uJ0DvghCfQ4JGvt1ZDsm/gRv35UnCV3aFs3hVqd6Cz/CP7gWyIWuyjRlZ3kRIpDWmG
	 XEpqCpr4ZJWZW1A20R/3R701q6a8o3YE4sc0TfRF4Zk9cA9TP8EaLGcl6LyXMkyoru
	 QcCOir0TliOx8Fe91eo9l3uLowelDwOlHvCpGjoimJxFq7Kaq+xICDF/RpzxTHybLb
	 4vuoHfxRJoggA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c029505b389so97892966b.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:24:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrtWenvvExLGgRz+t6qpVBRcZ9Sm3bcILOcHpKpodaXXLi6oMVPoeu6xhZjojjj4ZouNZRPNtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Vl6S3NMntG/XE3iG62x1SdyDqKmoRcNGZRsT/PN5Q5s/Im5X
	yMonKFwi66lK/12NESj2MTzy64KEGHlSwiwErqhkfhcWYwoJf3KdbGtPh5CdzNeb8oenroX122k
	my72cpzmEenjytiiYa6CfwAEZCV0xeFc=
X-Received: by 2002:a17:907:6ea9:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c12903c0660mr131595966b.2.1782829485135; Tue, 30 Jun 2026
 07:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1CB185090CF6721+20260630030856.2210012-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <E1CB185090CF6721+20260630030856.2210012-1-peiyang_he@smail.nju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Jun 2026 23:24:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8QFKFrx_9VsEjv-WRDKwFM1SKaWnR8w2X0AgXdy42yFw@mail.gmail.com>
X-Gm-Features: AVVi8CedrEkdCyh9pQM37Epv9fb4Zg4c-G1vQz4e1fqILJD2jmBHiKW-eTQyQyg
Message-ID: <CAKYAXd8QFKFrx_9VsEjv-WRDKwFM1SKaWnR8w2X0AgXdy42yFw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix mrec_lock ABBA deadlock in rename
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, syzkaller@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269985-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:hyc.lee@gmail.com,m:syzkaller@googlegroups.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,nju.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60FEE6E5717

On Tue, Jun 30, 2026 at 12:09=E2=80=AFPM Peiyang He <peiyang_he@smail.nju.e=
du.cn> wrote:
>
> ntfs_file_fsync(), ntfs_dir_fsync() and __ntfs_write_inode() lock an
> inode's mrec_lock before taking the mrec_lock of its parent directory.
>
> ntfs_rename() takes old_ni->mrec_lock and old_dir_ni->mrec_lock
> before taking new_ni->mrec_lock for an existing target, or
> new_dir_ni->mrec_lock for a cross-directory rename.
> This can deadlock when ntfs_file_fsync() or __ntfs_write_inode() holds
> the target inode, or when ntfs_dir_fsync() holds a child target
> directory, while rename() holds the parent directory and waits for the
> target.
>
> Fix this by locking the existing target inode before taking any parent
> directory mrec_lock. For cross-directory renames where the target parent
> is a descendant of the source parent, lock the target parent before the
> source parent so the directory order matches the child-to-parent order us=
ed
> by ntfs_file_fsync(), ntfs_dir_fsync(), and __ntfs_write_inode().
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9=
b3f-5da4809e7955@smail.nju.edu.cn/
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
Applied it to #ntfs-next.
Thanks!

