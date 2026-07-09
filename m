Return-Path: <stable+bounces-272954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SRCQHdy7T2rnnQIAu9opvQ
	(envelope-from <stable+bounces-272954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:18:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42487732BE5
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=theori.io header.s=google header.b=NMQ+Xc0c;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272954-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272954-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 217EA30765BA
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C64376BD3;
	Thu,  9 Jul 2026 14:40:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266537A4BA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:40:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608047; cv=pass; b=Q6xT2Mp3PXZMWraqQ8cjPMpUAMGhXB3M2WJcq4XFKGpKR32CGOcLXNVM+bAjTSYdTwJsrZ9zY17bi5iT/VPYR09D7Me0JiLp60trvgZ9m0K82G8ciwRQIlM93pqD+uDgZ/NX9voypcWBKX81hDchsrXpNSTl79H7ZH2UuWYe7wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608047; c=relaxed/simple;
	bh=YsdtQZV6+ux5TvtcnvygHRCp35Ysp0LOVNjyjfgxL/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b7p9pC7hLbBqaMzJwVXKr8G8613fglKWDtIpUf695opT+Jj+mRmC5ya6wBX0wzu3X0ZCxLfRhzlTcL30SskIOJCDjP22ckAZ0zrcso7RAUtoS+B0wc28g5OtYDyBSLgeqCoNnjhjjmqa5LSP7c1gft6DBtv2XDiNG5cb9cnN4oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=NMQ+Xc0c; arc=pass smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-476d8e647e9so822561f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783608045; cv=none;
        d=google.com; s=arc-20260327;
        b=THn//bvKsTgBOHbSjVgQRpNja4s7aWhNhbF5nVJvDOuauLEmYNmLg0W1RiTAJHBaKs
         5mOi8OG7qfooBsZeUipeuVP35dOcWYurvYFN150NrJlSX6kOJ/dxSmug7xw5LPGjrUBc
         /5QB2fL8BbtVe3Ldx+l2g8y5cT9nycF+rn1RmyMyUYBlcqKlkF9wkMS0kzt5XTqsDYVe
         JeHxnBLfLHB3adsKVKWoP3+fH7QYHNeajrwBPFu3Jrn46a+QUXh227w3unXMhhOeBZDe
         qy6NXJZEBFlMKb//zfZ4QfkFKZkDVSwBkTro5DOWFnUkml0u4wCo2lGuARnkRR417ks9
         rdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=I6TkCIWmo4zPoJw5GYcwJwDsGSmIQXTg0ThIj6SkkPc=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=pFu/gEPx9HOHnxthA560lWGb3qEeh2f7L5C2U3QkA4t8FX34FJxIIlaHDEsY/3/6Yc
         GDmqrrUc6Z8kVbJoniB3+dJFIouZvWhGbev34MGXlqyNgOp05UhWoZOjKxq0fO7M76Kg
         FsArXDYc3wqm625x/26ozajh5vmMwToZCBHMW0co8P/xtjmUHG3dkbAF5eU4r3RE20UK
         JZnGy4wAKFbzRwMht9dMl4uNiiWLDDjI8OAHXxmnnn41Hq/9VYFZUPM491QfWxtXJZ4Z
         7l8hX3RWYGOTCv9Jz/CBPVSdrViHTFt4vJfCiNinI2oZjbsn3wyZz0WTvyuVfbAWDSpi
         B68w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783608045; x=1784212845; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I6TkCIWmo4zPoJw5GYcwJwDsGSmIQXTg0ThIj6SkkPc=;
        b=NMQ+Xc0ceedaY0EmnRufyLNBCSorYwsv2r6P/kJFynpQOvUJFihX9vJnJufR/BDOLf
         y8ujhNJ1cu5uffQ907shdgxyKNDFlN/l6+/6bpRX3hMhJorQqvXJqWw96fny/rfwNRRk
         EJw9jOQc6zKcaPvLMN0WBU0vzmt7wuLUPV6O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608045; x=1784212845;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6TkCIWmo4zPoJw5GYcwJwDsGSmIQXTg0ThIj6SkkPc=;
        b=Uy0jIk3hRsGSZ7g4y1dX4+KHSzAFbnzQDxDNqPxwvz9YvrVqM9jMROmYNNLVSIUDHo
         0tl5eRAVuZHmp5Dine7GU9+6qOKwoNMLFece55w/xMMKrx2yFRX6wihyPT16cW8zwrid
         Xq7FKQ5dvB1WG/XEm0dQqA/QTj6L3hF3X01B192zLhNJuxPh7MccuZRmbIxpj5ETavsd
         D1iryVJMye02AqWqlnUOlN5v3aPYaijJvUj3zCA4caK7SrCYj862POF15NbIAIXHBSit
         VD5gtbbOwDfnxPcgcO/ACTNGeZet+Uub57UCM+m3NHEEuylXi1hBam+KnX8eTSTLqv2b
         EAww==
X-Gm-Message-State: AOJu0YxUeplKTXkDCaYxxVfZ0O1qWOXg3K5SGy1v91Ay7csO/K0gzAte
	Fu3yZrQnhcErpgrpQv0QZTsgZE8IDhv6wuK2B+k9fY9DbRl/uq1okxClP/Sgcviq/ZBrx/56K+P
	dg+tcS/xVyq3wxKH5aleJVdk63zatDrtK5XrU2MbClUoSuSFJYPejAK4=
X-Gm-Gg: AfdE7ckvB9fV46uxD/lXOhYf56ciqu+BXllNUrneemhuqrzcCd+wzGF/kqWPLXO3DTB
	CmbHNIt5bE/1UuRC1o1aZFN2FSJzpumRm4Z4fAW7mfWoQKJEYpeCH52NfD6j+zimDdRkwhXGP9K
	agXIrISpkqpdhSR0anpxhzdxrmuWqisarKyvxA6epUZUIOt50P6dtoIV0GVyZVNp/zug1Ilp/58
	Dl6toVEXEPSYluFj2niDCE+s8amPbI17meYQpLDvpVsQBVjUrW0l4fHoNvdaSkWn1M+XgePnr9m
	7/xVZGQdZ6XxheuDSd0Zj0jo6w==
X-Received: by 2002:a5d:64e5:0:b0:46f:7d90:8128 with SMTP id
 ffacd0b85a97d-47df0758b63mr9011816f8f.14.1783608044529; Thu, 09 Jul 2026
 07:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Taeyang Lee <0wn@theori.io>
Date: Thu, 9 Jul 2026 23:40:03 +0900
X-Gm-Features: AUfX_my5E5yWD7PwiXbGq_0jEJw0eOqRYNduNDdC4DqxkjMOWGS5jDykm7dhQA4
Message-ID: <CAH-2Xv+SPOO=O1kiBzra1_+KD9snB6eEUCHkhROMN+Txco5S4g@mail.gmail.com>
Subject: [stable] Please apply 037a3c43edfb: perf/core: Detach event groups
 during remove_on_exec
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[theori.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[theori.io];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272954-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[0wn@theori.io,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[theori.io:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0wn@theori.io,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,theori.io:from_mime,theori.io:email,theori.io:url,theori.io:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42487732BE5

Hi Linux kernel stable team,

Please apply the following upstream commit to the supported stable trees:

037a3c43edfb597665dd34457cd22b14692f2ba3
("perf/core: Detach event groups during remove_on_exec")

This fixes inconsistent perf event group state during remove_on_exec,
which can corrupt the PMU context active list.

I checked that the upstream commit cherry-picks cleanly onto the following
stable branches:

linux-7.1.y
linux-6.18.y

For older supported branches, I sent adjusted backports separately.

Thanks,
-- 
___

Taeyang Lee Researcher
Theori, Inc. / Xint Code
Website. www.theori.io
Email. 0wn@theori.io

