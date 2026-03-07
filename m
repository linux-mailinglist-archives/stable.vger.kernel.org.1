Return-Path: <stable+bounces-223424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMV4OIsvrGlUmgEAu9opvQ
	(envelope-from <stable+bounces-223424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 15:00:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6222C050
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 030A1301F9FA
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C64136358;
	Sat,  7 Mar 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2kWbvBi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37590C2FF
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892019; cv=none; b=fI8Iux4WCvfGQOoX8h3p47qyJO/s7bUa4M9czscge3iKz9lip/q5S+Hl3cY+KmBnEtqGtFvA7MDXz5JPjHnS4fEE5+1+sZsWl8WfQbx9c5wQCe0liO1JC3/QiBRGgyYmpGqXJGitXzODi0LH7v+sa3hhFTkvr8grkVmZalFT/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892019; c=relaxed/simple;
	bh=6z5z13sZJQWAx63WDddjUPDcrnYQA0Y5iP1sD7HHlDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JObq4cnj9VOHTljAabnmO/F+LHjdfJDIW08pQUpOGogCF10ro5OUmTA2iPnw5GT+wGOMNoppwDGB6eXMWjaddSjwV+nXsZOtRlDTD4Sn8n7oQy+hLobPyzySqWyWUuuAsjxablCsY2XdV+IyN2VtnjTc9QD0mRGIv4zKAEmMf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2kWbvBi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824c9da9928so5842937b3a.3
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892017; x=1773496817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRAH1OwRMd/hgomET3JR4h+I3zPtNpk+wbuNofTgx3o=;
        b=Z2kWbvBigLgXo6zl8ejWZX0BFIPUFidW1zh8g44fZ8naGeW4MgLx3cTJkz70NfJwl1
         DpA1Ns4hW9U4X2yvLYVRWQXNG3Wa4au4xoYvRefLWtqOFqncJ0fWkW+xjCKcVjNQ/pvL
         90WAn54znDeGV7F628hevYh/kjoCtSlkk8GnzznfLAx5493HdGICdsuzN1mqQjDWvfC6
         m4B4JpQ5KfrFDL9nr7XtoFtBVoN2RFvorQcHQNvy47ernKQa3VBhLqbeYDhkhZylN3bw
         1+iyTgvaHiXEQ6dNx2WPkqbcDyD29qEKQKNNbJWvBgOyNqJE0h9p8HKAqaiUI5VWrp/V
         iBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892017; x=1773496817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRAH1OwRMd/hgomET3JR4h+I3zPtNpk+wbuNofTgx3o=;
        b=Lkg2hKv4SYmcXyShSD5XkfRVEt52v3OF0h/RMy0nZa7YxoNQYIRjihH5as3ltIttX0
         j2f3dYBIQsCKMV8aVWhJjpvhwpoabuCUFWrMGa99mjnYOgvWmQYZKQWdK5Xwd0qiNzHp
         8d7CSnpMV8A9f2Dbbq5hnDZYjT53L0Ve8kRsztoBG3s8WZo+lGVT8pc00mrF7hX+5zHq
         +MtexR3wDDjVTrpnRH7OtPXAHdXeDHASbEPAcfugDzF7CEgBPoSsMsSiWKtXxkN1CHqJ
         G503oLx1AUjnPZ8RdYrL1KFUOjfUKfgyT18m39aaSZfRuwgeqCZJR1mzfCge2XtjqT+G
         2TSg==
X-Forwarded-Encrypted: i=1; AJvYcCWuGaqQHNLDhGBf8JshotlJeoCxyHD7HsxOe5ADQJZi3miynvHaSIPH7AwLJcYOxVDiith8KDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywszlu+qr/ezL9+di3BTc5tede+KQCeQaJ1HK6Lj97cgLDC5vdm
	poeCPxvfTlMyG1yLnSKOuq9nwl9QFdzohBAQecNXTB+HNVxRpNZpXJAu
X-Gm-Gg: ATEYQzzaJV5OIEkV/8NYNatAJ/wErvn9fdRY1IeATKhRKxzEvBcoG6tKf9874svsJvX
	Zsk/YrmbvOnzBOxw5oQNgxCFG/a8N1Rt7Rf6arTYuJIC+YZLPAu/GEtbgqSwpnXJMoFxmyxLZM5
	fjjPMlIvsI5whvbmAmX8hLoWxTTG7kOQ/2bCBMwkCudaFVQsI4hmq1rh9Pt3Y/qriHNYQqI5KVw
	Mby4KprAfjnfKv8MfQbiBGp0xgp/COFVji2C9Ts4nS8NydIRzfbzs7i2h/3KyZ8LBxzPaDVFSqE
	0bHJ27qm1eqozq106aMkyN827lzJM/Vxcqve5S1MNR3Qk/2M+ZyNQQ+MJFjf0xtP+AeSLN3IthH
	p9y8f1FTbkGojq7zQvAHpTW5FHyXmAnPvky1K1XgFG+F0MDgLkidOcsT/kI7fSgD6nzvycsIFLA
	v7Rb1T4Nfd+BeTy/wNAHRle2DYlKAujUkE
X-Received: by 2002:a05:6a00:7087:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-829a2f808acmr4078268b3a.50.1772892012838;
        Sat, 07 Mar 2026 06:00:12 -0800 (PST)
Received: from zjh-MS-7E01.. ([2404:7ac0:6427:b7dd:ba81:85a1:e5bb:852a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657a10sm4291425b3a.21.2026.03.07.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:00:12 -0800 (PST)
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
To: peterx@redhat.com
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
	rppt@kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Sat,  7 Mar 2026 21:59:59 +0800
Message-ID: <20260307135959.44974-1-jianhuizzzzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aasGkA4r56pLqNC3@x1.local>
References: <aasGkA4r56pLqNC3@x1.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DF6222C050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,linux-foundation.org,kernel.org,gmail.com,zhaoxin.com,vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.de,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223424-lists,stable=lfdr.de];
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

On Thu, Mar 06, 2026 at 04:53:00PM +0000, Peter Xu wrote:
> IIUC we don't need this; the userfaultfd.c reference should only happen
> when CONFIG_HUGETLB_PAGE.  Please double check.

You are right. mfill_atomic_hugetlb() is guarded by
#ifdef CONFIG_HUGETLB_PAGE in mm/userfaultfd.c, so the stub under
!CONFIG_HUGETLB_PAGE is not needed. I will remove it in v2.

Thanks for the review!

