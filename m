Return-Path: <stable+bounces-237973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N4qJ6yv3mlmHQAAu9opvQ
	(envelope-from <stable+bounces-237973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E9A3FE93D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3992306EB42
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA57384222;
	Tue, 14 Apr 2026 21:17:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860252C11DF
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201445; cv=none; b=Ujvm57LCTU5r4pCjeraOHG50IvqUREeA98iM2OWPqtBZMgZ5l9Ls0S+ZUaMyDm6dbvBgE2Btbo8CHMeoeSvKDM4Bb48AJjejLffOlJD+5N5sU86xg1Mo4Onp0+jjcgF53AiYzmprCQ+tddGX/F5XBC5kpSg9PJPIDDfXnwiwcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201445; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I9H02PfR7m59bQmEHuGi6t7zeabA7T1HbmuuOefU7dJURVqw5C9Las1sPB5A/iwDipt6ImqzJTncCmEExNgEpkqhTBTKxPLBVh77KuMvaqzqh6d6Cxz+8iWW8zKsKFKkKJOmwfJrw1HnQhUyzWbUZKclQCx2ipMJyukJQ26txpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-68e7e213adfso6837006eaf.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776201443; x=1776806243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=IoO8m3gzvm+AEKNhAWzxKAERpnk5LkowF71baPNuYEGibtF3Iq7RcPFV7pyY6t0y86
         6ptTlo0pKa+wW9vKTUI7H666Z8b/L3nZmm6Kcruat4K0rBVIZkiz6m4Mj376e+wrpiOt
         3o7BVfhj0zxla56nuvH9zfMkdG6EhpbE9kSG2Jx2mkDXt7CVIqtgR62ErgdXrELykIsY
         ajyGAQ7aCYKqdWjK0+z0j4mHyBWPVY4/gSdGp9kYl4pGZRB3sq6Xpy23RDnh0WtS7LL3
         bWIprtKMKm09UNCTN2xtZcdDwfuZ5lfTU2fTFDtE0PtxHSZUTOSG5wq59dFPc8zXBhjn
         mHng==
X-Forwarded-Encrypted: i=1; AFNElJ8YqgNxZ+TPYw2lIUawgXWxfvQwP8KmsAUUfamOqd25r+p5HtisTMpyQsX1XBZyZNGZ5WEgbfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8T0ZK5ngZL4FGHbrxQjjgjFFaDdM4svrY3GPJr3h19EsicvF6
	qe+yMfA5x1vsEGXt1jpzfjechsIG5TcRV2cxHdiC/SU1UhqY7SQUB/Z/eAE2Tvy9OavYY0v7XjK
	N9oCT7GG9CsrQOy/JcEK6+cd6ammeu/yjY83OHgRKVgPtZKXSz4u+YCprDN4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:310a:b0:687:d4de:1f9d with SMTP id
 006d021491bc7-68be652da4amr9513114eaf.24.1776201443518; Tue, 14 Apr 2026
 14:17:23 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:17:23 -0700
In-Reply-To: <696f61f6.050a0220.4cb9c.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69deaee3.a00a0220.468cb.0064.GAE@google.com>
Subject: Re: [moderation] KASAN: slab-use-after-free Read in bulk_make_private
From: syzbot <syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-upstream-moderation@googlegroups.com, viro@zeniv.linux.org.uk, 
	ytohnuki@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-237973-lists,stable=lfdr.de,c0fd9ea308d049c4e0b9];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E8E9A3FE93D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.

