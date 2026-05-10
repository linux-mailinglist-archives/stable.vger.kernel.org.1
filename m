Return-Path: <stable+bounces-245083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2sSqLccHAWrVPwEAu9opvQ
	(envelope-from <stable+bounces-245083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 00:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAB506B2B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E9F430073DE
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0683336891;
	Sun, 10 May 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Cuvnw9GA"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9D308F15
	for <stable@vger.kernel.org>; Sun, 10 May 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452418; cv=none; b=r+XT2VstkX+9QfA3IfZgW61pE1fh30HdBVlM+tY9gLBAGHkR1cpGogfSBKCr2pqIP+uoxKvEKrI3oudKG9BvPW4DRyF6Qw00gBdACmsSXs/YOdoxmuJ/XoSPsfTzeemn5Asz9SLCRWsC6eNwbNSWMEeMr35N66xUm7YMHpZrtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452418; c=relaxed/simple;
	bh=rvSqfPe31RmxHaiDt4N/xBs9n4hl2UED7B0sKqVsQUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTeM7mpZ10jiJoxgKcZf7RsOELh/v69uAtmQQoRi69pbYNDZSnXtrhzo/QH0myGlAx/MWLYCzGEu+qoQcl0RaxYZ9nUcOQb4J9EQCtZ9PEnwm2RcXktPWzGAeeLaJPVoIYhpy03zlJPf08yJv6iLnq5l+DmKMGzu63d7nMQaIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Cuvnw9GA; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778452340;
	bh=BkVxM+S5/CQD2rR4IzyjcThauNt8i+gz+BoPHv4JZfA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Cuvnw9GAN50u6+Fl+lTYiQs5vbqKdjixoWCuGKkzWqHj2LY0mUT33XGAgdeQY/43i
	 70xNwFoYg3I71VfSC+xB3qog+dg5rutJ7VPnr2I5k5f8qPlRXjPMGo9gvxykEjm9BU
	 Kn16dOfXkx+1t43MNcjlAzyUhzZGvG9K1DcEWqH0=
X-QQ-mid: zesmtpip3t1778452334tf99433d2
X-QQ-Originating-IP: 6sNBMD12FGonFJIJzjd+CncC8qH7mueGPtwrJ2A/sss=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 06:32:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3703982739077470885
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: jaltman@auristor.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Backport RXRPC for 6.1.y from 6.2
Date: Mon, 11 May 2026 06:30:57 +0800
Message-Id: <20260510223057.6945-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <DA1B1E18-0F4E-4399-84AE-75EFD88713DE@auristor.com>
References: <DA1B1E18-0F4E-4399-84AE-75EFD88713DE@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OYKM/pSuXZktyvI1Cr5T0vJh8neaOk7McnCXH/R2FXe/EuvKmuZcy0Fp
	N5XFoW2Y4ymRmsJSw6mDLwt1lumzieUwSoG9pQqIPWUCTaP6AO4hcu3P52Gth3gCH3qkshP
	Y8P/TfQW0zWtfXVHLAwIHG5dATWOOq5h5XAxzGDB/FPk9Q9znT9BaffXR6JRn+XfDJD9yX1
	FbjHkJ1yN//h9Af96RfvJzskpMjOfw+2x7pyFWW6s7o4cwbQpWHphB5mZ67VCZ4zjECpFN/
	wNL+RF27weJpM/ORrTI+l4HBjrZP7DuIl3608CgGYNwgMMXpNGfYRpCjUCmm3ZdZhEMtiiA
	/D5zEaFGxz6b9IYhdc1VnD6e0lG75HyRcjzq8tP5uSvbteTOXYuopU4B1DI5Ovz6QMc+F7g
	Ne1GgqolQQNKtKWLB9KV9aXaBHlyzCm13iD1+WRm+ti7uUM6vj2VqygAO8JGnc9wdYtFJRV
	G02XecMrtTGydpvdmChLmd26M3MZTpfVZp01dSVJUQ5Jz0OMGTlI95dqT/uSzVzyTGx7BxL
	07MK7NA/l4m2tcTKmVCPnWohoOGBixyWW4Gdb2CZXYUdJCg4bqcOsuqUwbqKMkL/sY0zsSC
	uAz0vsp4PDBGAE7qVgUwslXlA/6EmC3WGt1kn1dI9cEMWemLj3bCmzFhpXmBLMeKeM/k6NO
	ydEXiKsZVgda5+Sb8eU00B6M6hWrhczckC/6aWeyLq9feMrkTlKAEoEYzHr+l071zvZ2/7Z
	oFb/ZrMhLatLCjg2HT4P+02QHHng3xFADM2G/YWAq/QlL90q48jQdXymF+nnYFK3SQEg/+n
	gZdsPRsZ2Zm8PdF/Q4uC+dSLh23VX6GUwa1EWqwNo6APCGkjn2rgoLU8TMFJgh3j6d3kBLl
	HqRxH/0HV+Ii8oZebY2GcJjdRlGaURHDFma/5zqO4cOdUAn2OYqjXCxsb9CS2FTFL9oPNLW
	4PkqUefsEKbK+04IeTWgwcNDmT32hk+1VuSUAAO7sFygAV6jEqzpTOYu14XinpGqM92lg6l
	D2vvKstRIZrczAeFT/9R/nmZLO7B4qetv2o9zhBeHvwu5EGwDVbI8TXA5SQ/hYE3wvLC1lH
	g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E1FAB506B2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245083-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

FYI, I am bisecting v6.1.73(poc fail) and v6.1.70(poc ok):
ac8c69e448f7e43586e102395844a117b0595031 is the first bad commit
commit ac8c69e448f7e43586e102395844a117b0595031 (HEAD)
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 13:11:22 2023 +0100

    udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES

    [ Upstream commit 7ac7c987850c3ec617c778f7bd871804dc1c648d ]

    Convert udp_sendpage() to use sendmsg() with MSG_SPLICE_PAGES rather than
    directly splicing in the pages itself.

    This allows ->sendpage() to be replaced by something that can handle
    multiple multipage folios in a single transaction.

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
    cc: David Ahern <dsahern@kernel.org>
    cc: Jens Axboe <axboe@kernel.dk>
    cc: Matthew Wilcox <willy@infradead.org>
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    Stable-dep-of: a0002127cd74 ("udp: move udp->no_check6_tx to udp->udp_flags")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 net/ipv4/udp.c | 51 ++++++---------------------------------------------
 1 file changed, 6 insertions(+), 45 deletions(-)
so if the 6.1.y kernel convert to full MSG_SPLICE_PAGES will be vulnerable.

BRs
Wentao Guan

