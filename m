Return-Path: <stable+bounces-211232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVHMAEmcmkVdwAAu9opvQ
	(envelope-from <stable+bounces-211232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:28:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6622E67458
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 332E172C5E4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF5346784;
	Thu, 22 Jan 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOzgL2DK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE32286881
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085411; cv=none; b=AEEjvs676yah2Sh8nBGLIEgCc52OXI3hwmDkujMPpxdeLmHBcKRFpOjXqlo9uczkPKUkfXQ+3rc5HaKeZc4cR+ANlygeI0IKSonFVTEqf1fT9487cEEhHsMNzo7r4i7dAFelf/Wn/EqRFTrAMQgDHjsB3m8pBr7Pi1SyhGOxbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085411; c=relaxed/simple;
	bh=t71HJ0T7TteHu2rjW12sTSo9aXhFK1RhbfygAcXviVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr6xxoxRU5DDFQeVunT3ARnoLUD35ItdBsCUfLdrjJTWcx9M62/t2Tfbvl8mtKve8dmnV1MtNxycPRW43qivf01YhbeEYuWB6tYHjfB4Itmj0zbec3tMX1eh/N0Hp5k2vYk+87qBxbmWuboyQ1GJLtYu/SdNhHncWdxkQztfLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOzgL2DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94AAC19423
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085410;
	bh=t71HJ0T7TteHu2rjW12sTSo9aXhFK1RhbfygAcXviVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sOzgL2DKskYYn4QKIirCt+E8wTWLPBSmmhRHdGmM/sxKT0GaHymVkh37u+3QbfJz7
	 et1M5bWaXEHtTmMlTxwY6P6qhriyKeiy64pQz3aIXBRlCWgDYHtzYQb5E13nuJs5sy
	 NWeenR6pg5/SJ/o6T0INBA5YlZ1c9WEFSrsyYNNmtj2/r46dxCgNH8WBY5PeAnoTSM
	 K4DiBLBzY3tu36ObWWPYVapYYOm8oBllRR2kog9AQMVcNlQMNuiU30aEuID3Zes9wK
	 5vPIgOwvKic9X/bscSBiOXZTnk11G30y93sfNDxmK1u6H1Fp876pCGe2ealn/O5zBD
	 ej/6Eu8Hdz+Pg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so1411642a12.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 04:36:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1mGGRNVH5J8GA/VVkn+OnOUpdquHgJPk22AlxE8FIQg4uu0CV2O/9SVjBNtFUPrC/rpOmeMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8umjtRb+i4ouPLb6vjMlAjI9ZpFOsNGU1I9yRUWMeEoPjQpaM
	o286PnDBXtJ8yO1bqFAnHPAVg3X+9s2j5pMCsGCqt72tydF3skW8k2+BFkK/eeCysXnsQtpYSIj
	2129wDQcHP5F0m4thq6tPGrEZyLmc0gk=
X-Received: by 2002:a05:6402:524e:b0:658:eb3:2031 with SMTP id
 4fb4d7f45d1cf-6580eb322c9mr4621996a12.27.1769085409568; Thu, 22 Jan 2026
 04:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <9c7db488c53721cae463a856b318bdf3fcb0bf39.1769024269.git.metze@samba.org>
In-Reply-To: <9c7db488c53721cae463a856b318bdf3fcb0bf39.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:36:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_9f_xfp4HkOOsz+7CcRRzu9QNzRQa_TuCf9bEyUSvm1A@mail.gmail.com>
X-Gm-Features: AZwV_QhZZpmoFMEDQU_C8hWFndHe_sSrvdP8IKT-wnpmAs4Ty423xO0gqORj84A
Message-ID: <CAKYAXd_9f_xfp4HkOOsz+7CcRRzu9QNzRQa_TuCf9bEyUSvm1A@mail.gmail.com>
Subject: Re: [PATCH 04/19] smb: server: let recv_done() queue a refill when
 the peer is low on credits
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
	TAGGED_FROM(0.00)[bounces-211232-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 6622E67458
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> In captures I saw that Windows was granting 191 credits in a batch
> when its peer posted a lot of messages. We are asking for a
> credit target of 255 and 191 is 252*3/4.
>
> So we also use that logic in order to fill the
> recv buffers available to the peer.
>
> Fixes: a7eef6144c97 ("smb: server: queue post_recv_credits_work in put_re=
cvmsg() and avoid count_avail_recvmsg")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

