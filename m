Return-Path: <stable+bounces-223453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fiiRNs18rWnx3QEAu9opvQ
	(envelope-from <stable+bounces-223453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:42:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B223070E
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1822300F9E2
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28243815EF;
	Sun,  8 Mar 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8pDzW1f"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B936C595
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977351; cv=none; b=owuC6AOKveX99pFKE7bkC3+zFiD2zYXoYq0Jp6jqXE60vtFYDcFmAqTF4h1fhSSEPkMwyBPc77RAVPYO289RjOcQyCqq42ZfJG2wovaJhGV1M3tI+3B3w86ddyXtg0ZfOEZzO7JW69BBzLiZrsWwUETxIQmiAuVBEEJYSCLvpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977351; c=relaxed/simple;
	bh=NByE4PT0wqkfdJU03jkGo6aPNrHHpfER3sZMXEnWO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVz5y4/WZ9M8o/1+CAGPiE3Ln63qpe06TvDXWCU5HYOoVTx32wxlvsxy14AwRlyItoyipI7e/9YOCHsa2FU+ucT2FB3ac7j1ArpUl8wQCzdaBc2zKghqOf290t8WuTKlrrhUoQq8Dyw4jKS6Ha54AGfnbk+GcdXs0M6BxtNtZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8pDzW1f; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be27fa54feso7700160eec.0
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977350; x=1773582150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbKp0eloZA1EESwF31tdwEOfegEsBVQl6ISBISTgW7c=;
        b=S8pDzW1fcg7JK2ZgQ+fBK734E4U+mH/d2NWCmaeoA4kg6JiK2WofB0EMNl+NUjc/r4
         zjGVmibVwlfyP3vvCTqW46giAZmop9Yce8oP81KhHY1Qosk5I9E8fzfJvxGOTbGfhDt1
         a/dWDyfm2jPNGDsJSdF7Wd6zoBLO6RPYl8e8/g3ZKEoCYSUE+d1OEX51NLBTiWhq/J/g
         Z1lDrC+FEMJgzL6Sz4ECrvxema5xTg/NCXPQqC26BM1DB2ODWwxnBgBRFptJoVQ7CX1o
         9wydMl1PoQLmyX5VaqYXUO0RxeWalXniiKi2qll+5XEIad36/TiQIkU8qkOjryI5np1c
         QgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977350; x=1773582150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbKp0eloZA1EESwF31tdwEOfegEsBVQl6ISBISTgW7c=;
        b=LWKnyUaRDF7i8M4i0BJMFa1eaGbR0NZsgJ8rmT0X9mRGc5XfwfusHag9z+G9zR4cB/
         D9vzWDinPJzFW83Vm1OOgwC80OSOtN3bpSSJQlOkN2VTD3RRBQkko9yu0gWJLVjo5NoM
         M1/GMzpFRSBvCZGRorheOH2C2kE5y7WnDYw92/z6eAxargPmYHe9lPEUUGjrLtsSM6/Y
         7QhHum5aRYNzPne9qnelzRBR421RPI+lIK7EiMM9SB+CVz3/hpEvVEM2Tvw4o7o4U/iH
         jB4sOzIwf8GSxuPTi5DWDjKQEAdIm9FEFofyd78LcHUOGj5cMcLVrPC+q630MOJmTrAA
         kFBA==
X-Forwarded-Encrypted: i=1; AJvYcCUPiq77rnzu7xkXiXoEqrk9OhDjGe1lruydJM9vgwXiKk//MabQv6LpcGTh6/RnDypy5QSi2pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xszulZS2QLHv81jZ1KHNzvt9OB5SqBDIyj/8+YPiLipcrZWV
	JOEctI/2atwDRzfi7QJVChSR5v1J8hBhjYqT3JEtbndHBi573vobYBQC
X-Gm-Gg: ATEYQzx3rM2FoaH55tNBHvwJGeTLOV7I4RX1GrBtYmowU3lUwjpJwLeoSmVj0kSP/Ap
	jcJkQafeKwBhHiVeR0S7fhoceZ1v7cnDHqDgXRNiKVKZlf8Vdl4IxU14gE12dbHNkfLnZK5TLQC
	ybrWPKj1a6UmmUfcKCH2oak2zdc3coEemngRGFHfsvwE0vZWGbbLFBuphqweix7RKVqGDQp2FNR
	FEqX3ZzDogC2Yexs2XJ/D8nLwFJQnMrI440R+Y/K4DeiF9qWtkn30oQBui1AJoQJRp/EHe0XEKD
	Hk0eZN2SUK3Q6cE/jFFGIEjrRooU37Dhago2kido7byWfk6rh1zxZtFI3drLfKNfz+L9qww1OSd
	Qr733a4sFs9RHoJBMU2VrRxNujr70DEsb3Pc3R2aIaX8tk2m7V12M1t8P5ZCUUD1bC4NiWrc6tf
	gLLtqkYJE=
X-Received: by 2002:a05:7301:1018:b0:2ba:9835:112d with SMTP id 5a478bee46e88-2be4de928e2mr2880611eec.3.1772977349688;
        Sun, 08 Mar 2026 06:42:29 -0700 (PDT)
Received: from zjh-MS-7E01.. ([2602:fbf1:b002::1032])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f25bsm5636535eec.28.2026.03.08.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 06:42:29 -0700 (PDT)
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
To: sj@kernel.org
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	jianhuizzzzz@gmail.com,
	jonaszhou@zhaoxin.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mike.kravetz@oracle.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterx@redhat.com,
	rppt@kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Sun,  8 Mar 2026 21:41:51 +0800
Message-ID: <20260308134152.6877-1-jianhuizzzzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307032759.100915-1-sj@kernel.org>
References: <20260307032759.100915-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 332B223070E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[redhat.com,linux-foundation.org,kernel.org,gmail.com,zhaoxin.com,vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.de,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223453-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 07, 2026 at 03:27:00AM +0000, SeongJae Park wrote:
> I just found this patch makes UML build fails as below.
>
>     ../include/linux/hugetlb.h:1214:16: error: implicit declaration of
>     function 'linear_page_index' [-Wimplicit-function-declaration]

Thanks for catching this! As Peter pointed out, the
!CONFIG_HUGETLB_PAGE stub is actually unnecessary since
mfill_atomic_hugetlb() is only compiled when CONFIG_HUGETLB_PAGE is
enabled. I have removed it in v2, which also fixes this build error.

