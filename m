Return-Path: <stable+bounces-244941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKViKnUt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:49:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3894FFAA4
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE01304CE8A
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901B361DD0;
	Sat,  9 May 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFZCRgUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25932B989;
	Sat,  9 May 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330846; cv=none; b=ArslaZTDIgPUfaTanKtmwg72HCcQulNK94XZReQFRBW6XVsGh/2gNkblI4aMxTVbMQyWwCMAxDfrcLAcBBJc5RXpOhXKN0ouRPhShrDwEaFarRQSXZBB9NFnOu6DC8VMBzbjagtOkvAQLTE+qfc0EcaX1sgiy9T1iAMnR2vyzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330846; c=relaxed/simple;
	bh=XK5mhAUBfu3WjNswiiSxlvINMO13NiggoMGvmD3JwPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4EDqdOPNtB4Zqs0HOfEDY6UjJGnfSz96dMBfMLo4zvym35nk+6wxuDgHhmavOEb2GMTsWqg/MkkwcDkrIchCN/xFrC9v6Gol/mWC+/yY/y9lOZD15/1KjSUoy7mfAqWiz35FxhEzfQTAJcJkc/YK45gPHOs39Wrx1cijcNTBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFZCRgUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CB5C2BCB4;
	Sat,  9 May 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330846;
	bh=XK5mhAUBfu3WjNswiiSxlvINMO13NiggoMGvmD3JwPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFZCRgUtIv0K1nTk27PZNjynhpbIgfIQFGZCgtNVBiW6a+G4tdrOdr1SEf6Q8Ca86
	 k8dIA2xxEleOHhC0WMrXI1okEg2p87NPVBIdJgAWSyIFSkyd0eAu22GGQKUZeHsQbh
	 1535lK1qFLrbGQGPzUathroC51hl70NOrUMB7qtEqMZRimdxN/EUyy+awWqhH+q6IT
	 TCvRaDgTHiC2PwpQYEoXDCeD0ON80Fif2LrNdaOXxnptAcI5idCIXAfq+12blC/Uv+
	 DxingG9z2ol50OC0tojwJzjDJSK6cmUcratG8zE4th1dulWGINAWgb79ma7sDv1HYT
	 Y6giFrnnFzvkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Sat,  9 May 2026 08:46:50 -0400
Message-ID: <20260509122858.475f3b407568.re-kvm-x86-shadow-paging-uaf-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505070812.221568-1-pbonzini@redhat.com>
References: <20260505070812.221568-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B3894FFAA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244941-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

Queued for 6.1.y, thanks.

--
Sasha

