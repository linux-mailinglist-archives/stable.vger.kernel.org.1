Return-Path: <stable+bounces-244938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J+BLuUs/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535B4FFA39
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95DD93007B30
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A938945C;
	Sat,  9 May 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5FQ9dEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2393876BF;
	Sat,  9 May 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330843; cv=none; b=jFuWGYLJv01HlWJJGao492DQnqBF1jZxmE9Fkcnv14laK6fTtxfjpp0DNea17ysSq8OigDzsMgsPpx6G7TORj0Fy1AhdXxLVY3P+PHeuHuoV04lGZHfr4M25kUqy+Ff8R/S5V6y9L3JfC6F8DM1XDq51ysT55MEt5QdnzkUtqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330843; c=relaxed/simple;
	bh=6/b2OkitxMNFYu9enV3cVh7wspN7m5hqEO5MR09RNDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKf48kXRtRBbvBaxPdBtTUvHYtzlNYcJuijxgDl8Eqi7rzosF4uc6wSVi4OD5FpaKZH0dZJyr40yLW3WAL9PmZxeMq58lGyBzn4VRe12BEIZgRBr+E9y8O/OOY/I4zD6ZbFKn9RzAMeMLa0/y42jeQxrQBFJ6jzMapHqOPwE9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5FQ9dEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3366BC2BCB4;
	Sat,  9 May 2026 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330843;
	bh=6/b2OkitxMNFYu9enV3cVh7wspN7m5hqEO5MR09RNDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5FQ9dEbS5M4Q1nqeTgdPYgrwKNw96oL0oZ1skBmkeIBvMrhbMCL67A5Ejxvrji2s
	 BG+bXUAt6hZle/vyk7PiUkKCLY5CmOWxtDtrITc61HZHxV6nUJW3/qb5VedN1wJwC+
	 nYW3Zj7qEdvCQyCIchXzwouvBB5fUf9+/yAmS7lIegSRsDRjuaziqxDOb+4cxjyk5+
	 XyXagZcPET7iEnYnGPWMF+FQb4jioABC5yY4X8sUi3I7zciVkc+R8DhF97zhSRhexR
	 i5XCEQZm93rFxHNSibAL5uQg7yGDeS7HOokxfkN2CjTCOIo3gJB/xNZCX+2avmIEIt
	 mXfr7+KnS3bXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:47 -0400
Message-ID: <20260509122858.8afe43a9c80b.re-kvm-x86-shadow-paging-uaf-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505065857.190809-1-pbonzini@redhat.com>
References: <20260505065857.190809-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6535B4FFA39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244938-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.18.y, thanks.

--
Sasha

