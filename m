Return-Path: <stable+bounces-263011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MVmPCIhuLWoFgQQAu9opvQ
	(envelope-from <stable+bounces-263011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:51:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3E67ED33
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:51:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ATEp7Nyg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263011-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263011-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AE343002D35
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AD3385A1;
	Sat, 13 Jun 2026 14:51:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340727FD51;
	Sat, 13 Jun 2026 14:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362301; cv=none; b=QrJDDbHbprPGl3fTTVYuiPN9kkiVwoTFORunVCNCEkJaNxHEZL43JznHCs2GNdo2ydH5QotssIPsgIrrezJYVBTvu27hd/F1pp1gW+I1+Yarvhxdor7g8jIgHxQcozLUYlHvg45maDnlLRe/mOletiruMyQVgzF0vCNERnOXYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362301; c=relaxed/simple;
	bh=l6ajO6PEYiRPvMXI+CPCWfcvCib+DRUZjHwnIx117VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyY0NnTpFGLVy7dGHaaJu4KgKKBheAOIzMMFpJbg9DFj0zo7yvX1zlBJ3nnZSakYt+cknDL9B68g3Z+R0dG3YTx6LYwyHqDCyu5UUNtzKKOWXzSr8WCqiaroLO0ijFDNXWYiIL9PM7xJi/F0K7zvQMqCVYLl1SX8hagJk7nWHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATEp7Nyg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C071F000E9;
	Sat, 13 Jun 2026 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362297;
	bh=l6ajO6PEYiRPvMXI+CPCWfcvCib+DRUZjHwnIx117VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATEp7Nyg1KWkylf5Q4x2aSeRSrLRCwMg25N3l+DafS4pzdHGeTkEfGBIWBV3P2CdI
	 hr3SYx8cftxxcqANFuFSy3vEaaWT+8dYMQRL3a/hIKxyixLDrLbNkUweFDIBofXGgr
	 aooQS7SmBTBQne6TIGykTatvSZYbqr7584u85N4HjpMbnLx8EhiyQ1I2ZYz6ARxV3i
	 95Nfun10Qj/0DWeOA39SOLSCpYAEBNzrciA4ZMt8N4YxtihNhQSu5GNN3Ut35oBZcV
	 4CrZHueRHeKORy4qBzOJDc01a4y6xVnP6V112iRbRDkF5MF72pSJPaD/uvsSaeGpmp
	 LgxZkcgffV1Vw==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jonmkohler@gmail.com,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	stable@vger.kernel.org,
	Gulshan Gabel <gulshan.gabel@nutanix.com>,
	Jon Kohler <jon@nutanix.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv activation
Date: Sat, 13 Jun 2026 10:51:26 -0400
Message-ID: <20260613143000.0001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612211003.2503400-1-jon@nutanix.com>
References: <20260612211003.2503400-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:tglx@linutronix.de,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:jonmkohler@gmail.com,m:dongli.zhang@oracle.com,m:chao.gao@intel.com,m:stable@vger.kernel.org,m:gulshan.gabel@nutanix.com,m:jon@nutanix.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263011-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,oracle.com,intel.com,vger.kernel.org,nutanix.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55C3E67ED33

On Fri, Jun 12, 2026 at 02:10:01PM -0700, Jon Kohler wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com>
>
> commit b2849bec936be642b5420801f902337f2507648e upstream.

Queued for 6.18.y, thanks. (And thanks Sean for the ack.)

--
Thanks,
Sasha

