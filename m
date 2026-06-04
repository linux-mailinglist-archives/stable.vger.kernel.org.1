Return-Path: <stable+bounces-260221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OPKoOWvBIGpc7gAAu9opvQ
	(envelope-from <stable+bounces-260221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAE63BFAE
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lppVKYK8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260221-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260221-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E144302C773
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6DC8EB;
	Thu,  4 Jun 2026 00:05:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F018EB0;
	Thu,  4 Jun 2026 00:05:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531557; cv=none; b=p+092E1E0B3gR6Wv7u6SnLX29UaOYywm9/Q5wddmxuI4bJjRhUBiLN5ASNx5d0qmOHjUec8H9BH8XYsoc1SfEhmUcfM9dIKKksRNOHOp0Ssghs540LJOAxjpXDwTVQ89bDf8PXkCNSNDfNWE+T10d8Xv4JOvre5swEXvYmr3gRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531557; c=relaxed/simple;
	bh=kxp8vw8zN5QjoR+2FH+m9rOdIREfk1SQW9Cl1AogwWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tic/LZffMlYbGcz0RFnlrjuyceaLRGT8U9JMsp2X/JjDMdjQaUcFsRDYSm9PzvY08tIF9yJ1YANsAjsP9gq9iF8ZvWKXNjtVTj11IWIgxWNEXv9mf28/wekyAKnss3SnH4hgePRg6WVaA648kYKZLU3nessftDrdXJQCN7yqy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lppVKYK8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC8A1F00898;
	Thu,  4 Jun 2026 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531556;
	bh=qrSyg3+Cl1koNj1o41wo6dzgLaX0j53jxM9J07df6Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lppVKYK83KW4zPNCNEVHEThHQVDFHEbbugJ4F4uvGsuA0j7ZC53CX+NP5ajNnVpc7
	 ZY42LWJlI/N763ux95UtcslZ01dNmblkidj57ACGe/4h7hODk+81uZMafHNr6dFJJP
	 m2NZRZpJWPhx1Ci0oRcuPJQ6UQTo3eWIb5boV1NmtKjnjE760+WWsoBoipoAiizdgg
	 YrqQGhvXdgB/NsEt3gvIC7h8k3483CCGjC1gJiBSglrjVg+40MIW3MWmPxDeuLHv4Z
	 31K0iXDGrhnio1ZR2iQ8fsP2vbJyI8P2l7RGQoxs4LOtlLPwOYO55VJW+owhtQo04H
	 WY5To6j+AYxeg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	guoweikang <guoweikang.kernel@gmail.com>,
	Henry Willard <henry.willard@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Jonathan McDowell <noodles@fb.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Yifei Liu <yifei.l.liu@oracle.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y 1/3] ima: verify the previous kernel's IMA buffer lies in addressable RAM
Date: Wed,  3 Jun 2026 20:05:41 -0400
Message-ID: <20260603210831.item006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603130239.81400-1-jetlan9@163.com>
References: <20260603130239.81400-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260221-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:harshit.m.mogalapalli@oracle.com,m:zohar@linux.ibm.com,m:graf@amazon.com,m:ardb@kernel.org,m:bp@alien8.de,m:guoweikang.kernel@gmail.com,m:henry.willard@oracle.com,m:hpa@zytor.com,m:mingo@redhat.com,m:jbohac@suse.cz,m:joel.granados@kernel.org,m:noodles@fb.com,m:rppt@kernel.org,m:paul.x.webb@oracle.com,m:sohil.mehta@intel.com,m:sourabhjain@linux.ibm.com,m:tglx@linutronix.de,m:yifei.l.liu@oracle.com,m:bhe@redhat.com,m:akpm@linux-foundation.org,m:jetlan9@163.com,m:guoweikangkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linux.ibm.com,amazon.com,kernel.org,alien8.de,gmail.com,zytor.com,redhat.com,suse.cz,fb.com,intel.com,linutronix.de,linux-foundation.org,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BFAE63BFAE

> [PATCH 6.6.y 1/3] ima: verify the previous kernel's IMA buffer lies in
> addressable RAM
> [PATCH 6.6.y 2/3] of/kexec: refactor ima_get_kexec_buffer() to use
> ima_validate_range()
> [PATCH 6.6.y 3/3] x86/kexec: add a sanity check on previous kernel's
> ima kexec buffer

All three queued for 6.6.y as an ordered series, thanks. This also
resolves the earlier build failure from cherry-picking 3/3 alone (which
I'd had to revert) since 1/3 now provides ima_validate_range() ahead of
its x86 caller.

-- 
Thanks,
Sasha

