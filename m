Return-Path: <stable+bounces-254526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJzBAj2/FmrOqgcAu9opvQ
	(envelope-from <stable+bounces-254526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:54:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4E5E230F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FE6731E82C8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A443EDE44;
	Wed, 27 May 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oMGB8Uq9"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8B3EBF18
	for <stable@vger.kernel.org>; Wed, 27 May 2026 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875188; cv=none; b=B1h2JU7qt0hxP17GvilfTdAQogKgj5gC3bqkHiVNRa9IS71DWT38cyl59bC1IOFM4wwJRaWJFLws3DLirA+lo7kU3Xavu987iq5E70UbG0YLBAxpnfZkRHvYkxrC7yZ9IzV+AMpdnW/EdODd+M5dEwGFmhEA4XI4PjfeZTlItDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875188; c=relaxed/simple;
	bh=Ia0yIbhdqpKtebMPGbigWhsK4eOsrKkpZkvYwRjp0Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goi/8+JZ0aonsrdVO13jJiNoI1Y4sp+gj6/NAI0/0LRapjmAyzLO2ez3h3rcuNbCWE8iD8peJiWk//9CmKgAppytcG43P7Rw01xHFjgu/1+bqkpue628dQAsBiijmk9t6wcTpECecb0gmlyqttunudcvPbkg8ETkKV9F7YR7LW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oMGB8Uq9; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779875150;
	bh=Ia0yIbhdqpKtebMPGbigWhsK4eOsrKkpZkvYwRjp0Kc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oMGB8Uq95bC+V0625xryI4FLeufQ66SbfNC70qlLzCCmZ/dZ9yeb3sYfRq/7B5gcq
	 2+VbE7tGo0WncBaOyfTaZlvmZ/cJwaaNlrhl2luhcQQq11i3e3XOF2Nf8OsXT6WKhR
	 mD6BMSTFEp9DAeLmuO52ZQXOkECefq/yGrhu2SHs=
X-QQ-mid: esmtpgz13t1779875147t35b1c9e9
X-QQ-Originating-IP: ePvmYdHkFpHo6PoZ1NIT/fGc+g26VcbfqO/F6xSTWGo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 May 2026 17:45:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2997212932578719407
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: bird@lzu.edu.cn,
	kuba@kernel.org,
	kuniyu@google.com,
	n05ec@lzu.edu.cn,
	patches@lists.linux.dev,
	stable@kernel.org,
	stable@vger.kernel.org,
	tomapufckgml@gmail.com,
	wangjiexun2025@gmail.com,
	yifanwucs@gmail.com,
	yuantan098@gmail.com
Subject: Re: [PATCH 6.6 229/474] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Wed, 27 May 2026 17:45:44 +0800
Message-Id: <20260527094544.2344825-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260515154719.961677988@linuxfoundation.org>
References: <20260515154719.961677988@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NshvC2+mlzw32QtyezAd0qZh/UxK3VnvVYhQ9cfWC9GCWgeYm/sqZzRU
	7o2kMLAJcTTnYT/l7NiTz63BE6IwUiNgM/olRei7hrOC/Hwzk/tjmKyPmnQJDKCxUp+oFnl
	aHC8IyHXHtUl5WDy1nsM4FC/2YmfTuDTNMncoPvqLNyU6v8UmjLjbDqPsa3l/1NUzQWRs12
	AH9VLYPsebPSL9HNppyR+pt4ZTBuReF2gl75m1cpTXMELqN0upFoME233WeBqqM4hgKHAW1
	p4MsVO7OrDwzJo7WeWd0pj6O8u0eLe9KaBPBho0SdKP1jNCqNKpvZw0XSiEPjlt/rNwhu/u
	3gV0lFbj7L2Tm8c4+0JdSH5OLPWrjP0HQWE4Shb85ZtWyMTz0kYIzxziL98fJJQhfBH0/HK
	6gaXUIms04yxYOWlQAA/OvW/RtbhPNvLu7QhQCKJ56FGHOXWALwhXrw3yV0qBTKbGzyPCPa
	zUCMdHqovSLPnmGlRATFZPMKRNhKsd2A4HosDToJ2MDeRfykcJzzfHekW/F+/vr3Y1HfqRO
	AlNFuIMR12g2U1zFNuvy8fks0HpkOs5BSEo4Z8Th8JvAxoDh42vF3XxTMxgc+/Vyx5ISs1L
	+/EA6/K+vyO9hbKaFe3NfScpg8SgnFGM4vKDDETnVV9MBOROsKbEXSoM+fzsAy11Uvk0Hdf
	uEqRPz3ggEvNeSU10b+HKjKX3LVuuMYGNrhLd7NIBUa2HDsCud6QlgOsOidHlnLQngsEyB4
	ThIxBj0rtI9v3z2h0dt75bHnvU85IMVGHBs5DPDMKXz4GUefj4Iwo4WVZL/ZTJeHFFWmwVS
	LctdJq9PVKYgigbr0uGb3MOO7IgG0OWPJMerlENg/3Y/ueuwY8/nUIDNYN0sKODZH4jd9xv
	ZgoCexqKu4fXoxORWybVUTd6rAx8do3LWeKQLaMAPOZ8QtdnUTb01BDy7r6vWILWBZrbSyB
	MPCZ6Evk8rjtVIuWuq6/laMYX55O/QkCa3Yk0LmaxTOUnrdM31HizocAeDvxeTLvdDpNcFl
	n1Zb9P7ZI8HG0bqVSSAeImb+YnNPxlV2DiLD+vog2iz6mtVQh6
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,kernel.org,google.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254526-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: 15B4E5E230F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Greg and Sasha,

On patch review, found this patch which backport to 6.6 context seems such
different than orginal patch, I think this should be revert:
commit 0d7e7235bc543c6ed7b873e3015db814d8e8c414
("af_unix: Reject SIOCATMARK on non-stream sockets").
pls review.

[DIFFERENT]:
original patch patched in unix_ioctl(),
this patch in 6.6 patched in unix_stream_read_generic().

BRs
Wentao Guan

