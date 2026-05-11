Return-Path: <stable+bounces-245147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCLsFl6JAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228425097CE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76C06300679C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093B39D6D1;
	Mon, 11 May 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lnEiUWoj"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602223A16BC
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485583; cv=none; b=AO7/cmGBSkiYjv3GV708NiKaYk3hyrq7XqjDKhVf6J8PnP0lUx6D7Hh1oXTnVznfDXUC6luHKnY+bS3TwaMhjDaIDly9Jb/IdkXGeGwrp9D5w/JWEB9xIARLmmOu4+7yX7Tq1bD5PrNSeDG225eB44vZfznF7S95adTDDQ8u3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485583; c=relaxed/simple;
	bh=/bEZAiBaVe5xmBEtj5j+UKNTZbS/0FnIAP4RgZfBNp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1XtJBDQ934OMt1/8iYbUAZZR50a8XfA9PchVyHedila6DKDEm+xO0PZ2+xDyKoVgnDwko1qVSPw9Jy/UVax5I2PNoFwuzQfgBGt77rC5MoNKZYKj+ia9AbUdutqMkWKBRT69QR8aHWuLIDpiI7OmQRuSeQfxagehZIE8oOAeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lnEiUWoj; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778485492;
	bh=is5F5pznUKq+2mxHLLrs665YS9v6J34j5/v6s+KBDVU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=lnEiUWojAaouwbZWTQybOIqvZedB3GElIanT+lGxLVDF7WVEPj2BM7vKSdPtq3OlS
	 9JtWgaZQUHthXyVJaOXQj53St45085Nir8KcbvbUZhqPqUQYtKhavu+kgNryKCf+2q
	 X99nQro5wUUNp2w7ziLNNCv0B8cWeavP1IjKJwUc=
X-QQ-mid: zesmtpip4t1778485486t82f406c1
X-QQ-Originating-IP: xI0gcQ9cgjaEMM2NflJbYTEb0gME6/R16SuSrUIEk5c=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 15:44:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18093469423650949631
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 15:43:29 +0800
Message-Id: <20260511074329.61101-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051132-equity-umbrella-a786@gregkh>
References: <2026051132-equity-umbrella-a786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NzKFrlI9LzSQNOWuN05dLKPlQu0+RGAiD0VcK2Ga86jsOoweYXb7Wolu
	xz9Ntyanp5GpKv3ThE0TCvYcinTqjmCL9uhSJjbQ19Oyq23ApMl0HSf8UjDy0r4VSnoxeB8
	pWZqGrzYgFU2lYsv1GVJWMkCJEFPKWlsktzd5sRVEoXYvT3KYmoyb866r1vi5KucdNBspay
	xT+zmk0HIgbP134En6ex0OPvVr/OL5CUFtvlxiRS0lNjlxfp8XRSFN4w16R03QBDOdjXGZX
	I27b+vZELfvpLe+h7B9rG3u39BgycB2rmGAz9sbgRcGlH+F0M2QPHaqaf2sfNIGOsYP+aD7
	2/fzkYlzy0KaYJHtCKKuO64idjeXuj+VlBQcCF5XLSgQ+LnYvvvykJFIOCnGXqZhVrMeFEE
	M3ITf1a0SrqI/V9bEA8mWqR31k86b1srrzfZC8de8n5ldsPit3rqIrK5No3HmaK3ADN3Drw
	/BBVLXRO8ZAwaksqyhJfPdMo0VjccNjJwCDn467D1f1DvNzxitRK0CSVwDhComASeqAqdyJ
	E5L9aUoc3A8MPOVvUMplHAJBKk+sfemn7e9Y7KCSYCHp5NqAsiKnciN1Zopl96bMqXRmwUK
	bvDRAojGDVFroYiQIaowX6FH45+kUYG4J7s9XnGr6uFTJrRcKbjY9KRWusbuSlla1U9RTSA
	Vq9+OiAyZ898uXyiZaDTIaPLFXX+Wwt7UlDYAfFOM0nfUx24Pi1w4m//M7MFF+K/E22SjT+
	VA3Gq2+9TCRuKbccKYCs9Wc7JftZr2FkV9pQEDbaa0oZ9ELO2oBxwved0YY2+oHaiIMtb0X
	GsZzEVVQfZMZOYy0DgIycGrv++cVKlApWSbubIYMh0JmzpOWWxIpJtl9/NECTnYZDL0VWMP
	/kzCcpb/vVqkT9Nv9Q7UqNL0ABFJUNH0LZfCY13cXd4SzYkM0XtOW/gZuyEBUGQUn+PzCK+
	TqFnKoF/8cXSnvytXg1QX5Teq3yfk09daMZOq7eCPhsCE/lMHXyl8X+9qKHP7fVPad7UQNw
	/58u223AI2/s8NvSWG1+Yh2PE7TAh91ZM8suRDpxg+oQfav2nq8NLco8F+tek=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 228425097CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245147-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,uniontech.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:mid,uniontech.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sorry, FYI ,it is only for 6.12.y, PATCH v1 which i sent 
will cause build failed with no rxrpc_skb_put_response_copy,
and v2 also broken,
which introduced in 1f2740150f904bfa60e4bad74d65add3ccb5e7f8.

BRs
Wentao Guan

