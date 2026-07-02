Return-Path: <stable+bounces-270289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MsyFA7qzRWqgEAsAu9opvQ
	(envelope-from <stable+bounces-270289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:41:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCD6F2A99
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:41:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dl4ToLj8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270289-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270289-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E5830ED333
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2673272E6D;
	Thu,  2 Jul 2026 00:38:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF09242925;
	Thu,  2 Jul 2026 00:38:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=GGpcph2XfG4kidhydQIrzl91kZCby3vIJzs0qWcDSCv0riF0g+YXLvOUi6R7y68MN65XdmS3zy+XB1Er8mgg5ywkJBgChzTxV9wO1PlDJG5+aLTUGs+xn2FqTCgxzemFjthbGFg6T+X39dwJpkjTvZJACmvLYVPF5dxxJysE6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=3eaoi2HWX1iTWgJk0njPWCSzkD74duN7e42CgIopuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF70m6cJtZj+Peg8MlCGpsZSFTefTQPurTIfYYNrANn/+iR80UjT8smi+rIBquDBpz1/Xl7q7NqhcLG4EQj2N+FbaC3CFQbjT+6GeYMfqIZgZFVSxxg9xJzQA7gM/lo4Wa+1YjjHhVqvAFpm3xDcYWpvsWd6ZxOUEgjkoKT2eK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl4ToLj8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D01F00A3E;
	Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952726;
	bh=owwG2+p5ORursGxn/KUTmZwkVJhRYTch8Poq60cJ/cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dl4ToLj8kzu9RWIiAaWrdGkE5aZimpeMQ7Ja6hj7La6jUUhK5zHwW0GzTKWsgbcxZ
	 KDaWq1oZVpALPZWxMSfFodwb/cbPRMtIf8OnOgf+zMdLvl3VtsfGqQT/cPJSBdW6a/
	 oo+FaIX8dt80Hafwvq+JPytvY86DS4PtDCvUAh4j9z2brySB7gUsxFN69CNRpYJH+1
	 Z4L4MPfkAoYcNA99btVS0Oo+lkmpCo79Mok/eXTpMdL6UsmUALM7TkOTLR6sjVbXbZ
	 o+UciDuQ7JSJmHvGOz5WMlQ+FFxQqHLRuk8AbNFjNXCmCKHmDFfDTzFFVinTbbWJ0c
	 qNFxlfErhH5aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y 0/2] KVM: SEV: Backports for GHCB leak fix
Date: Wed,  1 Jul 2026 20:38:29 -0400
Message-ID: <stable-reply-kvm-sev-ghcb-612-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630172204.279784-1-seanjc@google.com>
References: <20260630172204.279784-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270289-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.lendacky@amd.com,m:michael.roth@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFBCD6F2A99

> Backports for what are effectively patches 2/4 and 4/4 from this chunk of
> commits (1/4 and 3/4 are already in 6.12.y).
>
>   8618004d3e89 KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
>   08385c5e1814 KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
>   f041dc80de4a KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
>   db38bcb33110 KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

Both queued for 6.12.y, thanks.

-- 
Thanks,
Sasha

