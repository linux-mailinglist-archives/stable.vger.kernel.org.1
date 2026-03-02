Return-Path: <stable+bounces-222605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IChfDauapWnxEgYAu9opvQ
	(envelope-from <stable+bounces-222605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4E1DA704
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDCC8301C6BC
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E823FB06D;
	Mon,  2 Mar 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2xj67eF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF213FB057;
	Mon,  2 Mar 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460188; cv=none; b=r02z2Qem1NLCzvEg7T251IB7+3aLsxuQydM8qr2ZjQDBy91L6VVkZrIWr5b71DkCISNBycE0yqhB43IbftjOfZCS7PLKLN7G2t4FYyUfXQl3vp0INu+qCMN0wvgYzn7wTHDdajacQbqkZw3+GZcHYEjhmC6trnaLtASOS1gEWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460188; c=relaxed/simple;
	bh=uS+jEDkHQBDcJ1fEw4c3e2YaXyaB/oeV4gKk2RwKeRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D263go3uJJ5he6D/RgZ9sD1Z+ETAKo4Y8cmqrNG1cM5lx3JU23/ihHJ7RbsqC8sRnrY8yTGzj6tKX+LogD5ReS9G9XR0DB/DEU0liEF/++EwqmoFCqVul8+9yoW05E4TIeuSG0TtEpS7yBMhf7r5MowIHAKvXyJUq1XxB3iUi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2xj67eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B09C19423;
	Mon,  2 Mar 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460187;
	bh=uS+jEDkHQBDcJ1fEw4c3e2YaXyaB/oeV4gKk2RwKeRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2xj67eFK9JHGvAYXEwBCssHFpgaV6iLmtGA066xshF7A6OYPOFrmeIRy8YkWSV0d
	 NtmE6zLvkLjpe1n6pUTyxyZP51VH6yUeyYubxwYt8Opck5iMw7CQlxRZWLoVuPHwyR
	 62aDZfnyad997BxQjSDEEQNrXkCCSOznKNVyuk0v6ECT4NUh0ogGUUKzzTzKkACnLc
	 DWKNwoxTU9PAG8p6opCXAkL4+MDDT1OPWTtL9zwf427gCexX0EYDjCqY7Z/9kzMITR
	 5PpeJmVLIvKZqig4iIYkv1wXh8kHQ8lZjBhq5BF8X1sPqL/RKSh2i90De9zxDYTpWV
	 8zgbqhyBzNFNA==
Date: Mon, 2 Mar 2026 09:03:06 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>, r772577952@gmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6.19 689/844] xfs: only call xf{array,blob}_destroy if we
 have a valid pointer
Message-ID: <aaWYmj7D2SB64ViX@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-690-sashal@kernel.org>
 <91b4797a-77a3-4955-86d4-06ac4def8704@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <91b4797a-77a3-4955-86d4-06ac4def8704@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222605-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,lst.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31A4E1DA704
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:06:04AM +0100, Jiri Slaby wrote:
>On 28. 02. 26, 18:30, Sasha Levin wrote:
>>From: "Darrick J. Wong" <djwong@kernel.org>
>>
>>[ Upstream commit ba408d299a3bb3c5309f40c5326e4fb83ead4247 ]
>...
>>--- a/fs/xfs/scrub/dir_repair.c
>>+++ b/fs/xfs/scrub/dir_repair.c
>>@@ -172,8 +172,12 @@ xrep_dir_teardown(
>>  	struct xrep_dir		*rd = sc->buf;
>>  	xrep_findparent_scan_teardown(&rd->pscan);
>>-	xfblob_destroy(rd->dir_names);
>>-	xfarray_destroy(rd->dir_entries);
>>+	if (rd->dir_names)
>>+		xfblob_destroy(rd->dir_names);
>>+	rd->dir_names = NULL;
>>+	if (rd->dir_entries)
>>+		xfarray_destroy(rd->dir_entries);
>>+	rd->dir_names = NULL;
>
>This cut&paste error is fixed by:
>e764dd439d68 xfs: fix copy-paste error in previous fix

Queued up, thanks!

-- 
Thanks,
Sasha

