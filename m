Return-Path: <stable+bounces-244847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCn5AIZ0/mkIrAAAu9opvQ
	(envelope-from <stable+bounces-244847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0204FCDB4
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF63303CFB4
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B25364E84;
	Fri,  8 May 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdTvD5Qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7B364046;
	Fri,  8 May 2026 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283454; cv=none; b=neTgscS0PyPxOaJcEDKOTlNvu57ky6yVYdt4CoYKTK4uIxqqL55u2mwhakJLExuIAP5SDL952oV8z5MLEWWsQr4Ue3fTXNExAhRfooGrZ6boVYSb+n46PTAlnHYh+BMyfCz2BNyODfwNhsYYuGPSSwoqDdGiJz7WQh5/Yh36uGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283454; c=relaxed/simple;
	bh=ZOCw0OOeU+2n3RSBZ6ipq7VEoUHHcYp9wuN0vVuwqeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwxCpR9iAJ9VOgVVMTXXMz1ByVvd2LgmtwUd+Z1unMsyKYjy9LKlDjhBFCjBcpirHrHXA4RmmXltqDnFSOFPpRvY2io4gbQMFUQPVSn7wD8zIxIpMRzJOvolELWaVMxSxmyFmmQCiku1dgQPoM2lnsOPoQ2beNWAQVnkKSPN1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdTvD5Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5AC2BCB0;
	Fri,  8 May 2026 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778283453;
	bh=ZOCw0OOeU+2n3RSBZ6ipq7VEoUHHcYp9wuN0vVuwqeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdTvD5QuTgleJJ0gRPBtMPblaoS5rdIE0r4et2hBDJVqHqsWuMLNdCKng9NXniFo4
	 /BI9ST9yr3sp9NPlLLw1RVj5ojw6yR3NOupz9BDOUlLm6LWEhrijRFZV6fjz3ltboK
	 8hujKYkYZZ2IYw+/8rFhxvia/ztb+T9Ja5yHDF2ThhCNLy1mn2vQA0z9EMCx2jiKSe
	 SzSZK8V2ENiB2yhfH6mqe8aiNNbPOJo04vrWkxKYc00KrlEyngWAqt2o3q4vCcXtea
	 nM/VcR1M2XI9BozOjuspRtO80FNPzGyI2LIlqf4iCgt3btb0BPi6h2rFujzG0fFdkz
	 ldQg4VrjEJ2NQ==
Date: Fri, 8 May 2026 16:37:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rex Bytes <goodboy@rexbytes.com>, Igor Russkikh <irusskikh@marvell.com>,
 Sukhdeep Singh <sukhdeeps@marvell.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: preserve PCI wake-from-D3 on
 shutdown when WOL enabled
Message-ID: <20260508163732.6d04adb9@kernel.org>
In-Reply-To: <20260506104211.2442-1-goodboy@rexbytes.com>
References: <20260506104211.2442-1-goodboy@rexbytes.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA0204FCDB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244847-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed,  6 May 2026 12:42:11 +0200 Rex Bytes wrote:
> Subject: [PATCH net] net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

Oh wow, Igor, Sukhdeep, I complained to your without realizing there's
an atlantic patch that needs review on the list _right_now_!
Please take a look ASAP. Link:
https://lore.kernel.org/all/20260506104211.2442-1-goodboy@rexbytes.com/

Rex Bytes Good Boy, give them a couple of days, and then please
repost under your real name (both author and sign off).
-- 
pw-bot: cr

