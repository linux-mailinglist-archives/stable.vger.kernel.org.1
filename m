Return-Path: <stable+bounces-235482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HwdLAzx12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA53CEB60
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED7BF30240A3
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB46303C93;
	Thu,  9 Apr 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZopG6yEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C909443;
	Thu,  9 Apr 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759624; cv=none; b=MKzmhk5Udro6JtLgSHSz462U3PS26RrlgxyrbG13sMuchKL2YoiZiUDN3o4SvA4aTBnH0Bn+4nqj7grfjrpxq5A0PiIMgdLbCoeUT39m1rGkCq9AWFzkrroJxf85CiFJv0ZBPLnmroVyPfQm1rsOtwWexFTenlqB1mCv9Yih+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759624; c=relaxed/simple;
	bh=VKrAtMk/rBKFIyq1PebyO4kZsd6r9RHsUyaniD1TvlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hnyh0u7FvIi5NvTt9/9KvPvltSktUt6NuRgUDWAYAqKq/TAs7ZC3+C1sUtC9blK8SH0sifxGPDYADc7ik/AtcmSbgj8s3MvX8Y7FlUWAEeVPV7dtHMZcN1KkQCcnMnlsoTDVOf75zNpio7XdI+WKZnVjfE641Uvsob332SDTAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZopG6yEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14E2C4CEF7;
	Thu,  9 Apr 2026 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759624;
	bh=VKrAtMk/rBKFIyq1PebyO4kZsd6r9RHsUyaniD1TvlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZopG6yEwEbzJP46334Y4yTvl1fonBxQLtY0Q8i9VfDTXfdHzp6yMVmEXq3v2/Sg6a
	 NWzs7VcpE47P0GuH9NAKCO7d/YrH/R/+VZHX3OZhTAmObgSzfxWRv0vnQImdgmS6Rb
	 eMxg4Yn6dG8loDLArrt9kbOcwFMalO4kFkLDWJ6a3tqQxgjn/maMXXsCu/Wrnb9mfK
	 Hw++OJUvGdNARvW8wsKmqsrW4IjMEt9jMW2+VxKACOj9h/pK08K/Ss/oyOmZAOO7FH
	 88DJEz6srRoM5dMkwtADqmCnm5vgNg2Dpd2vFRuDrn460v11DHzlD5VH91hdtVgLPQ
	 +fZm5dUbzgAig==
Date: Thu, 9 Apr 2026 20:33:41 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
cc: gupt21@gmail.com, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: mcp2221: validate report size in raw_event
 handler
In-Reply-To: <20260324170606.5407-1-sebasjosue84@gmail.com>
Message-ID: <465o88s0-2241-810o-0r60-34o7r2qqror0@xreary.bet>
References: <20260324062403.341855-1-sebasjosue84@gmail.com> <20260324170606.5407-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xreary.bet:mid]
X-Rspamd-Queue-Id: 5ABA53CEB60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:

> MCP2221 devices use 64-byte HID reports. 
> Add a check at the top of the handler to reject any report shorter than 
> expected, and log a warning to aid debugging.

Similarly to ft260 -- where is the claim that the device can't send 
shorter reports coming from, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs


