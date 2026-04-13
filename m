Return-Path: <stable+bounces-235894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OmoBcBv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E744B3E740A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E67043014840
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015838F93B;
	Mon, 13 Apr 2026 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGlemP1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22B382F1A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053632; cv=none; b=nByLCFZyRcQKC8N/P6XDEIU6qGgrSeAdTFFClj5uBoTmAXHBiI1P1Q9VPWFy/ZE9XU/GEkbkEDVNEeNnZoc4couemyHMZ2jaUOLOGPcSNEYq9TOhWpuCwExEtnv0ivGNwjoAiJ7/hCrIxK1QYHwNZRSgk+FBVKMMuqdqwydmbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053632; c=relaxed/simple;
	bh=yeK9UdV/EbYiS1FAhAJIUD3SAMRhmD7CeTJAykrl2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f25ZoEqaQ8ASj0xU4ab2nxGDFV2xpn/h+tBk6qB/h8y38W3EGYjfxw3X1hcWZ7T5ThW5LmEgeJMKa1Fe+UAWhlQ5/AIm4bcfwik4nPANfVqa98XIr+RN09m1+nGOMEzzXQVijZwggHTYj31V/GCDKFZMvE4oPR/0gO8gzX+2rXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGlemP1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0B9C2BCB0;
	Mon, 13 Apr 2026 04:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053632;
	bh=yeK9UdV/EbYiS1FAhAJIUD3SAMRhmD7CeTJAykrl2mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGlemP1JZt/Ei5r0TdfAgcthFaVHec0Csg0n61CMZTqtIRsTk6HIINQ+DBx8fj4bs
	 YKHO/TXEkHQHtIoq3Lnh0wKunMZMW0+HUmyFpDroPeVyZXG8PkvefqG8woS+//lGi8
	 xvDrMJHf8nyEAZufVi6ywqkdJ1uAc+j/R8bnAVoJr7t5v5YjbBvS/KSBeFyRDojDXh
	 3Iw4O94ELNS3/qAcD3lL8s+OCWsTCJG+6FXH55ALgvs5WcBXmo+4OMD6WvDmPdnG6q
	 /cWHmlmVBjtZ+vAK6SLPJ8TlCkuU1wZ6FnzdUXc7nJO2licDBoTNniFcx7gIl26nIb
	 fXx4QdErJbx5g==
From: Sasha Levin <sashal@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: af_unix: Give up GC if MSG_PEEK intervened.
Date: Mon, 13 Apr 2026 00:13:50 -0400
Message-ID: <20260412120103.af-unix-gc@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040752-sequence-bladder-dd8e@gregkh>
References: <2026040752-sequence-bladder-dd8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235894-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E744B3E740A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I note that this was not sent to Stable, but it should be included
> please.

Queued for 6.18. Cherry-pick failed on 6.12, 6.6, and 6.1 due to
conflicts; working backports for those branches are still needed.

