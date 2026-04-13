Return-Path: <stable+bounces-235893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CyBMLxv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB233E7403
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C6C304148F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EF383C70;
	Mon, 13 Apr 2026 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdUp/YiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F38F646
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053630; cv=none; b=TD+qImZtTt1mXS8x/ePdTi98h8yXPDUgy7WXBTLe93dS2wc+/rLP9BoQAqcXvDy82vYcJc1fAu5ihQkrXBmQBZNX4gI703QX+GvoOeMUHSnQael11F+AiRYUvGrnwa8sC5UP4NkxmdSKTNuHMGsQPuSFSM3lMOpkB0djlhFw9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053630; c=relaxed/simple;
	bh=w/Qy76g+W2xdrHXOS3QApe0P18B6J6Bdv7lrlSOtYMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoDvVzcbXiv++DSZQk6x80NDs6B7TJOMc3I/80qx99WGFbvBJbRhbn8z9K1041wcdBHwtG0+sVNhGwug7mKYWnY77ZpHGto+HFmKGOoxukl9kXXSse4d9m6bQZWBQft/92fXwzFbk7M6OUmS6LuKfipWcPwz13dn76DwzcOm+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdUp/YiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8680AC116C6;
	Mon, 13 Apr 2026 04:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053630;
	bh=w/Qy76g+W2xdrHXOS3QApe0P18B6J6Bdv7lrlSOtYMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdUp/YiZu62pmCRXJskUMM1bz1OmCVDyfVn7l6K2dhq5E1g+6FSq2ZdNjZi0cGIbf
	 mY797hI236xRWYu2UEtG1UV7Pcq5OL6cOAcyumoVvpXlKNjDMO923fvJgPNYxSQMlI
	 kBZhZAIE0fTv+em+3Wo1pyHZbZ1cNdEEUkbjqTA4S/MCfcNtoM1yzdeYJiXoJcRvlH
	 MLD2OUzWIO9pfUdec/Z+fBmMpKSCepUehHIJ1U3LOAfqh3pFZSlZb2TZ81qlxkTUwn
	 CpRNyWgzrQC6q3aRfAkIrQEQXQC4TIdqu+sL50/6u2KK5f05XTY1t78TljQUf6nHm/
	 3cPLnWx3A8Brw==
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10 0/7] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather) - 5.10 backport missing
Date: Mon, 13 Apr 2026 00:13:48 -0400
Message-ID: <20260412120103.hugetlb-pmd-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218130552.55727-1-david@kernel.org>
References: <20260218130552.55727-1-david@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235893-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DB233E7403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> However, the 5.10 backport series appears to still be missing.

You're right, sorry about the delay. The 7-patch series for 5.10 has now
been queued. Thanks for flagging this.

