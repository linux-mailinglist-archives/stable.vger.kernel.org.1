Return-Path: <stable+bounces-211234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHQkBHclcmkVdwAAu9opvQ
	(envelope-from <stable+bounces-211234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:26:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7049B673E7
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81DFF94A6E1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545B2DA750;
	Thu, 22 Jan 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWKV8a1u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5202D8795
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086099; cv=none; b=QDijGU9Vz1g7dI4dq2DWDU0e6atGeYHYstDPgl9A3JltdRDpairkj9JxKKLjvwGKlVBDLBWk5PtfkLY6sfGjahoAqdMRXHXvd/+Ph2JQcR9c2Lv+Fr9VoZXv61ZIbFuyY5wblZ1Vn+ubFhYM1vgBJL6EdwiGavEQLwBg9fbAJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086099; c=relaxed/simple;
	bh=2/WHl849NuQcFQNDU9fJWdHP7W9CnumSpRjicgxIwJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6615g1rAsmsAcjMJUKXsGm4bg/jcL+V4cz7tu87twbVgCrfaHEI0B+8BbpgFl1lumfIjBbxAByRnqRkH3TkML/mf8ZZOJMesk0qxXOpoonouvdFS8GwX71EeKI9R5wQadm1Rj3BqZ+Chjd0a7n3fN7Z15sm7tBtVIUUnuM8770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWKV8a1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04171C19422
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769086099;
	bh=2/WHl849NuQcFQNDU9fJWdHP7W9CnumSpRjicgxIwJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GWKV8a1uG3eCbcQgjsRHAgHx3eGuuwuru6/wnGfIhD+bJblht/SDkp070KyJ/8mUO
	 5cMsJRTTkfNQwfjutza7pRSvpqbQdJ4gKMbYqOpZcihD0G8U2v+OecC2e7dqQTq+Nv
	 k2e4Uy/fRjq8m0lxTvayToRgfObvOaw6GO08lv4QFO5PP3rqRIDigW2wOJtvl/EQeL
	 0yhQsu6XTouOIuLubcY0uzsBDWvCl16L0qzVF/kbV5gvgC+EISOjp7PcDDWPuo9lpt
	 kUQ2+LOd6YWg9Yil8AkBcmM/zwG1YFXR8IX5SKBG0qCoVrfiB1cDf8aAHCYUsWAPT8
	 yUcOZvQ8iJd0Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65807a2012fso1573012a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 04:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWN0AMca3V76Ifv+1dqgdcEm4yQ++DkEV+QG8SMhgRlk1+l3No89Ac+JpTEPYNmbe5fqNEP3is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rPeailadM4ekbNRZvN1FE71FVvbvh+PyeFDa9FhkJ3wzZBx4
	CyhqKWnChg7acz8XAECjciHAgyF6XNdbdw588QwLxTAFW5wBCYiWRJA/4g2xF8qDj1vsDW2FHRB
	IYf75RHicMYsdKLhArXCNqOVW4peIsYw=
X-Received: by 2002:a05:6402:2681:b0:658:1917:af4d with SMTP id
 4fb4d7f45d1cf-6581917b121mr2795893a12.9.1769086097539; Thu, 22 Jan 2026
 04:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <27b48512bb652a9e1662c9321971f42c88084c4c.1769024269.git.metze@samba.org>
In-Reply-To: <27b48512bb652a9e1662c9321971f42c88084c4c.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:48:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9uZ30n6QTufjYHGdwnYrdoYX8YB9o=ACtSF44Strb7Cw@mail.gmail.com>
X-Gm-Features: AZwV_Qgmhy9wuuNuBBrza1C0UMtqzGxmzhHUz2khZKvtLa8SFvErauE3nsmyxNk
Message-ID: <CAKYAXd9uZ30n6QTufjYHGdwnYrdoYX8YB9o=ACtSF44Strb7Cw@mail.gmail.com>
Subject: Re: [PATCH 06/19] smb: server: fix last send credit problem causing disconnects
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211234-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7049B673E7
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> When we are about to use the last send credit that was
> granted to us by the peer, we need to wait until
> we are ourself able to grant at least one credit
> to the peer. Otherwise it might not be possible
> for the peer to grant more credits.
>
> The following sections in MS-SMBD are related to this:
>
> 3.1.5.1 Sending Upper Layer Messages
> ...
> If Connection.SendCredits is 1 and the CreditsGranted field of the
> message is 0, stop processing.
> ...
>
> 3.1.5.9 Managing Credits Prior to Sending
> ...
> If Connection.ReceiveCredits is zero, or if Connection.SendCredits is
> one and the Connection.SendQueue is not empty, the sender MUST allocate
> and post at least one receive of size Connection.MaxReceiveSize and MUST
> increment Connection.ReceiveCredits by the number allocated and posted.
> If no receives are posted, the processing MUST return a value of zero to
> indicate to the caller that no Send message can be currently performed.
> ...
>
> This problem was found by running this on Windows 2025
> against ksmbd with required smb signing:
> 'frametest.exe -r 4k -t 20 -n 2000' after
> 'frametest.exe -w 4k -t 20 -n 2000'.
>
> Link: https://lore.kernel.org/linux-cifs/b58fa352-2386-4145-b42e-9b4b1d48=
4e17@samba.org/
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

