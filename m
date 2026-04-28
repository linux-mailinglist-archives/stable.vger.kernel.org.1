Return-Path: <stable+bounces-241651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN15C6Gx8GkfXQEAu9opvQ
	(envelope-from <stable+bounces-241651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5DD4858F7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C24330CF85C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A144BC90;
	Tue, 28 Apr 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY2DXsaQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE744BCA1;
	Tue, 28 Apr 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380936; cv=none; b=Wrr0N8N+j9ViRgW5uoXhtDdDeIK/bRQd1VBfkp8HcXkTyPXV+qYzddBFlPshzUmzZmXamYvadMZRf7AkE62yR2Us1BUMsf3GIRTtSePst1189P0U5j/DroUaHHp2Nb1Omxq4HHu7K5MbISSAgUeXdLfV8qwyeBKCgJPk76/hEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380936; c=relaxed/simple;
	bh=K87Rn1ViAGDdXf/nCYAAwB1QzMjonrtoOP6KHjiz0TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRIVZMCdGeV7VJeEc1VnHFQ+FRCB6TFEWjGJp2/4lsMgSr5rMepdYsJBms0Y6BZaZvAx+yy6uJM1EmNjLfPoOUl0TPVyauY/7XbdQM0o58zibsuPgX7zHlFqDmrWEe+rf8XHluBZMLAoEPq4RUeHlVudf2rOKzxvEFtWPYKZQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY2DXsaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A4C2BCB5;
	Tue, 28 Apr 2026 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380934;
	bh=K87Rn1ViAGDdXf/nCYAAwB1QzMjonrtoOP6KHjiz0TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY2DXsaQ7OvH53cUEj8eg2ciNzCX0IdVZ+OB9praxtfl4IdR7vzhurTdso+Gt/IBU
	 yHDJ4HDArL5YUXpDqf0QQbebTUFe3sDqMlcfvJXQ8Thhkwz9o6/qrcOFVIpuoytSsy
	 HcsafCGXyVk8qjR9DoC/7NSnBHiXihG55IU02tTLBKI8DvH3WTue8xmNNM4UPTZ6pG
	 WaPYvYx5TLlm089HV6Hnd8tZhjDMBzOCZUrX1MpLq5CwbJuLHjLyQpQZ3L00NcXpY7
	 hE1pAdQJaJxYwIYbgesv0uA2qCB51+VkzjmwS3kdLISl/3I78TlZGz+YwNJ6k6+9RO
	 F70gk0FEm9YYg==
Date: Tue, 28 Apr 2026 13:55:23 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 0/5] nfc: fix multiple OOB reads in NCI and LLCP
 parsing paths
Message-ID: <20260428125523.GQ900403@horms.kernel.org>
References: <20260424180151.3808557-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424180151.3808557-1-snowwlake@icloud.com>
X-Rspamd-Queue-Id: 8E5DD4858F7
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241651-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 08:01:46PM +0200, Lekë Hapçiu wrote:
> This series fixes five out-of-bounds / underflow bugs in the kernel NFC
> stack.  All are reachable from a remote NFC peer that the local stack
> has already associated with; in the LLCP cases the peer only needs to
> send a malformed frame.
> 
>   1/5  nci: u8 underflow in nci_store_general_bytes_nfc_dep() lets the
>        attacker-controlled atr_res_len skip the GT-offset subtraction
>        and cause an OOB read/write against general_bytes[].
>   2/5  llcp: parse_gb_tlv() / parse_connection_tlv() trust the TLV
>        length byte without checking remaining buffer, and the tlv16
>        accessors read past the end when length < 2.
>   3/5  llcp: nfc_llcp_recv_snl() has the same TLV-length trust bug, and
>        its SDRES handler uses an unbounded "%.16s" pr_debug() that
>        walks past service_name_len.
>   4/5  llcp: nfc_llcp_recv_dm() reads skb->data[3] without checking
>        skb->len, giving a 1-byte heap OOB read.
>   5/5  llcp: nfc_llcp_connect_sn() walks the TLV array with no length
>        validation; a crafted CONNECT frame drops it into OOB reads /
>        an unbounded service-name pointer.
> 
> The series applies on top of net/main.
> 
> Lekë Hapçiu (5):
>   nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
>   nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
>   nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
>   nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
>   nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn

Hi,

My only feedback on v4 of this patchset is that somehow the
threading is broken: each of patch 1/5 - 5/5 should be a reply
to the cover letter - 0/5 - but that does not seem to be the case.
And some tooling, notably Sashiko, seems to rely on the
entire patchset being contained in a single email thread.

