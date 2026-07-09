Return-Path: <stable+bounces-272774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P8e8KZr0TmqbXgIAu9opvQ
	(envelope-from <stable+bounces-272774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:08:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C206572B954
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EjuP8cpz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272774-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272774-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8625A302600E
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82353612FE;
	Thu,  9 Jul 2026 01:04:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1238C2DE;
	Thu,  9 Jul 2026 01:04:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559093; cv=none; b=nHocFb4OLO4uh57K0p2qs1QX6QBcDK7npoUNg+aG1VU6o3jgOwEoJ5MO0oTDeXaeqR+FCRv4mZElA81JUl23z6U244/jO/RMIF+v1e69ijrkXAKnM7cNLsrFVY8Spn/6ff+myDW1hslOgRbZalNurIURGbQPJkDIWdzpMepuHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559093; c=relaxed/simple;
	bh=xUs4wAy8JUb9Ic57L2kyMPNp79QTUf3tscDEOPv85gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAeU1iEccFim8Pxg9PPZn08G/9kyr8hz0mZmk4myo19/EFHRjps3BnifmZOzOQ44el84GK9JSOPBweOKFIwC7i9RdIsgh7AVkFAsx/YBFnrW55WYgk+XWYKXM9ur60kYhD4VsLCcZDApqPaci79lajfUK39ddFXdTua6an056bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjuP8cpz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6D11F000E9;
	Thu,  9 Jul 2026 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559092;
	bh=PsqFAtt/QiPLYAvf8WoanRCKQA0mCWJzQjJEyhGxIcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjuP8cpz615bGCqS+Wx3a0DcogUkF5ac0TPjrNtqEGVxCpXY+bn84IZnWHWoSD6fL
	 j4pp5YtbUuU1kQuF9obftZAeuGSgSGPvp9GI+l6Som8b7xOj0qUqTLQcCuo4+WCBzz
	 /aoVzB4ZXA3L/Siy7wkXtyE5OzJCljP5HyDlo1nV6+rAT6OZOCRgDYSyAf3lR3bu0o
	 SBqECDV1XzSFh5h6q4Uh5qBwTKUeXnCo9kcwjTS6GOUKlHa7i9TYauQeT/0ZYtM4j/
	 XgPnYJquOUx7m/CwR9CMt1+3UwXTtuWfwwuRB5tLA1/IfGjsKPY81UvZBf4kFcdYh0
	 ez1Ar1fDEP3jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
Subject: Re: [PATCH v2 0/2] Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
Date: Wed,  8 Jul 2026 21:04:45 -0400
Message-ID: <20260708194323.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707220526.271712-1-mendozayt13@gmail.com>
References: <20260707220526.271712-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272774-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,intel.com,holtmann.org,gmail.com,nxp.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:luiz.von.dentz@intel.com,m:marcel@holtmann.org,m:johan.hedberg@gmail.com,m:claudia.rosu@nxp.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mendozayt13@gmail.com,m:johanhedberg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C206572B954

> Root cause: upstream commit f4da3ee15de9944482382181329bb6d7335ca003
> ("Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID",
> 2023-09-28, mainline v6.7) addressed the OOB write in iso_connect_ind()
> but landed without a Fixes: tag, so the stable autoselect bot never
> picked it up.

The upstream commit cherry-picks cleanly onto both trees, so I've queued
f4da3ee15de994 directly for 6.6 and 6.1 instead of the v2 patches. That
keeps the eir.h include placement identical to upstream (addressing
Greg's review) and also carries the getsockopt put_user() hunk as part
of the original commit. No need for a v3.

-- 
Thanks,
Sasha

