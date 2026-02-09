Return-Path: <stable+bounces-215561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMwcGqlJimndJAAAu9opvQ
	(envelope-from <stable+bounces-215561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:55:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B432114A0A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E4E430074EB
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B230EF94;
	Mon,  9 Feb 2026 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0EZPqbF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7725B662
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670497; cv=none; b=VFWDl5rpkYSHmji9YtVcPQGuBCUZqDscF3BlL90Dyff8VH69lt/o+FMlLvX2jR1iLg9C89qYiWA2RVa5DTea9fp9njB5M+MbhrTa6lUe6TDn0lyYvhKaHadLAnKv1dnFZG6DS60C7A7VJgdUaGZgsgx9GL2k5c0sZ8yCKTKSEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670497; c=relaxed/simple;
	bh=crfzvfb+EQyP7co6U28Mt2PAOo83gcYmpPEk7cIvods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEk1wsa6w4EpeAUKn6bfLpQsUgNxq6R3DnhF0+7tzIMCvPcOin6MmFBOcpY+uBYoZ3Wz8HpOG9ng24nmoiPPDznF1nQQ0fy1tBmWMM8GfGYk6fTEVAS3wXNtnSiEbbu8vpkqlbBAkR2aN8GtS2Iwrv2+xdvj820p+GK5GlL5+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0EZPqbF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so19697866b.2
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 12:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770670494; x=1771275294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjkgMbNfBd9VUUE0WPihEScdlfIp8E5T3mmr+C15Wb4=;
        b=N0EZPqbFkKPWGgHvJnlGBs6tl+jHb0kkW33SgODrcSKfdpBlXpmZCXQ2l0zpSxRz5n
         dkLJkX1wOURxhrFg+AtYXwNkWQ3kkjYv2SFDDZztldGjbKOi62/Dy6zs7xPBfPOH0yIl
         jiTreaQpMNgt64DmS4vQZPaLHyB6o3YpRIuxJYc9ZzHWKDsjGRMJcQigrk+LfG+IA00Q
         392wXfuz3ayzxaNs5vaaXidza58YKTHsFUsq1BtKJFcszaR41CS1pH2PEPVBQ2G0iJ6y
         gsV1qLaahzEV9V3Yrl6WfD/83IizIBUsfjehfhcv9pxQssf4Tj6ic4CFLLQWK9ejchDy
         AuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670494; x=1771275294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjkgMbNfBd9VUUE0WPihEScdlfIp8E5T3mmr+C15Wb4=;
        b=MnngZU6nPJDB+wbP6kcqj/QbdRLPFHe7RvdFNXDEHc9ajnqUqDkXVyTfpTZ7Ct/6cL
         w6V0MYcKKDXRfgoDMQEG4UCifr9HQSn6x5htV58BWXqihy+sqfRB5+2c54EixCnJarSm
         geZOiqm6i29PK1ptGEVUKLRnwxgIQgQBAq1tLnmOsHjcx6VN+xB4EM63/yGE/l3jnK97
         KtS5tLRgg7WUp4sc4qEqHauLQOuvmp2IBTauDuAPQZHjOn7JDWDnux5sJ0OCNPWe/s/y
         X2TK7WBoJsmZS+9Kem9jKB2bPLaeqRLFsctW+2l0DWlmgnQPotRmlLPEfRYAj9xIH89R
         Bgjg==
X-Gm-Message-State: AOJu0YwJFuA4R8w/YMKfvX0/vZQvL/TsATx70HbeuJHOn+RLHkeqAf+3
	5D9bqruXBR3SZKnNLFDlmmb7zrtf5V+hUjCmXPxTpCMZbKQKti0+Ooi6X/3Q6g==
X-Gm-Gg: AZuq6aLbbjzXg6n8xlYE2xVVVvNCHmsSGwh3Mo9DrSKa/Wewh3lReac9s/2WzR+b8z2
	P+SYue2zIWJ003QRFa2Je3gi0qjkHDXBpx6Jb9soZkxaM0vy9mbLBLbxo7QnLlOzSrBbr0/Q14K
	bjXbS01IEarglEIECmy/KkPA+dXQDKDdIvZ1LNWBYvcNeH2re6H6uzZN9Bl3jZ08arDcifhGxqb
	RPgvobbKZy+SH50ykZsMvEZXXh8KvD9JH76JRDDBrGLXy06QTRTkZ1qo/WIKG0SiaKWmrJKZw5p
	8CuQolgiH/uY4Jrr74yLXbAlC+TUKp2LfVh/7TC0tAHhLgUWRfgcsk/lrRq+dDrtZgYbIhIpcRv
	Z2SCnEJ7cYKXYWVQUMJ1PnBljZBN4604qLhr2zG30uHfgIuAoptTNgRE8LvQdpjkk/4rIWueR1K
	l3jTrVtPzya4vJszObcqqCU82Rqamn5ddly0PKT+TSxpCU3oXca37hYOOKdePMbrxvlzpPsmWNg
	Tib6TvhsoGr224H0DkT02M=
X-Received: by 2002:a17:907:7205:b0:b7f:fedc:2711 with SMTP id a640c23a62f3a-b8edf427693mr793220466b.53.1770670493990;
        Mon, 09 Feb 2026 12:54:53 -0800 (PST)
Received: from kessel.tendawifi.com ([2001:861:4d05:15f0:d58b:a088:bbef:9c19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6598400f06csm3138870a12.18.2026.02.09.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:54:52 -0800 (PST)
From: Souleymane Conte <conte.souleymane@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Souleymane Conte <conte.souleymane@gmail.com>
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
Date: Mon,  9 Feb 2026 21:54:44 +0100
Message-ID: <20260209205446.8101-1-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215561-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contesouleymane@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B432114A0A
X-Rspamd-Action: no action

Built & tested on Lenovo ThinkPad Core i5 12th

CPU & Kernel: 
Linux kessel 6.12.70-rc1+ #1 SMP PREEMPT_DYNAMIC Mon Feb  9 20:19:39 CET 2026 x86_64 x86_64 x86_64 GNU/Linux

Tested-by: Souleymane Conte <conte.souleymane@gmail.com>

