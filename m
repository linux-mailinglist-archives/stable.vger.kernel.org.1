Return-Path: <stable+bounces-235481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LjTDArw12kbUwgAu9opvQ
	(envelope-from <stable+bounces-235481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:29:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4153CEB09
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E79A23020D7B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BE3DE42F;
	Thu,  9 Apr 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXR37xns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3E2248A3;
	Thu,  9 Apr 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759341; cv=none; b=omTV5wEVorhSrLMiJFi31SV3+kEpKLZaX+KvJioY56X9GdW4pOTbO8qqrved34gyT/J5vP6wJhJgFOx0ksUNxxPsi7Go4UyKL7SMRhbQOpTqGJsNO8kXtXxpjVMa8m2uUhtCr9AIGz5GARe1eEPXTobR20qIjU3f9AOiT44s3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759341; c=relaxed/simple;
	bh=0AqsaCjs/tsyiHjFNYYlGjRToMZssCVn6w9EUxIWAvU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U6+tNSwVTmOF8xHx6HsXICYj2bM8Itpw5xSqXoeQIBtAOXfcJe4RWLNk5uYvaYvDMhNaDHULc0RMGrwVKISXOyh0UO2/ByEEBUFCCxcaQ7zzsYtHpROwYvaBT9ou5ROrvC2OmFnfmbG5Jf+Q4TshYWyiYW+eeZjuNuZg7fyUSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXR37xns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA336C4CEF7;
	Thu,  9 Apr 2026 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759341;
	bh=0AqsaCjs/tsyiHjFNYYlGjRToMZssCVn6w9EUxIWAvU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PXR37xnswF1OPt9Ff/ix7mzS4fsQDqAJaJ8OOKycyv4OLM+L5gnLxAnQH7UhwSzgd
	 /ruxXwtsaCgGannct1CKnX8gFaZfszUTHSBrol1iWWjQlWr9O2QlmwW2eaV/zyiJvG
	 z/zxRBS+dx/oPxDYT/dKsSHC9d3ezY/tdsNxRiGDSVw5GO40DpGgDR2EaxS1gmp8uZ
	 jQP0bNf24yFcfOiMFxgCFQ6qHuETyS2/QLoClwwdX9e+6VD2k68x3VZjdri87GFN2f
	 32nKHKv+uhYGneDIi3uPKk+B2apcF9DZC6/w+yndwwm3dA9WxgqlC1p37E66/dn+eF
	 p3NcwTVtmLutQ==
Date: Thu, 9 Apr 2026 20:28:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length
 in raw_event
In-Reply-To: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Message-ID: <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
References: <20260324173527.11321-1-sebasjosue84@gmail.com> <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet> <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235481-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xreary.bet:mid]
X-Rspamd-Queue-Id: BC4153CEB09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026, Michael Zaidman wrote:

> The FT260 uses different report IDs (0xD0 through 0xDE) for different pay=
load
> lengths, with each report ID defining a different report size in the HID
> descriptor. So yes, the device can legitimately send reports shorter than
> FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break valid
> short transfers.

Perfect, thanks a lot for the detailed writeup! I was rather suspicious=20
about the bold statement in the changelog.

Similarly to other Sebasti=E1n's fixes to various other drivers. This will=
=20
need more thorough check.

Thanks,

--=20
Jiri Kosina
SUSE Labs


