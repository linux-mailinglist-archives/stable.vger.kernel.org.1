Return-Path: <stable+bounces-216639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGXyBr4skmmVrgEAu9opvQ
	(envelope-from <stable+bounces-216639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:29:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4213FA5C
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCFD3032062
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D62FB969;
	Sun, 15 Feb 2026 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrqH4eQj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45001548C
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187385; cv=pass; b=V0XacenJRntUXEBiVqgSHZG6um+uKx45bJ40SHKg25RchhBm5UlVvK/8yiTl5ucpPFzj43onrblS4RhBky1ckFMxblIJRLT32vP7ssyP9pGIghn9qqyFHnRoyFk5heVMDt30aI/QJLizapfBNd9izW8RpBy7yeTvG9YKbYNtR9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187385; c=relaxed/simple;
	bh=EoOlafacNg61H7V8WCD8xonXQS4mC6A5GkwHOiBDzls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4VUYce/yHfZSbkbtXfVPp38vMkQ1dYYSRLT3syX08JROjdF9lIYb672u+rMdbTqP0wAWEiVhJ4yfzb9zNrT3Rj9Wm35IHh4aNzSjw3NMWKaWxY1u9e8tbNo5t3yjcCUuQJwaozqK0rOVO9pBzegkkRpjPJh4/JjqvFNZT22+ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrqH4eQj; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb40277a8bso271645285a.1
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 12:29:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771187383; cv=none;
        d=google.com; s=arc-20240605;
        b=lAT5ay8bGiyxh4+ukJLlpPQSB/yz7El6cO0m3tWy6JP00JruCHdbxYyfYUUbK6zDZA
         dHnUxt81w8R3YIW8vmurcTF9qkaZxP2q7GmMxmOmHHL32NKb6w5HKYSfOWOspVY64zvt
         puYYa4F2kLonO+opwM/N9G7sgTA0hAatjCqcVFEB+VB7Ta4mF4svt7YBUaEpU3UzhqiE
         jD0wrB0zmEEG1HZTb3aL0r0zPa1bUxrNjq3m2P1SFl3Fn++Ps+oczFaTQs9R0gX99tHG
         3TQcotEZ7qlfZcdDA/h8OsrlQhxl3+ViEWooIc+lccrfjKUTcE7yS0FYfdoPJZCb3hwA
         6Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpCYDdCiDeg+luhgldp27Z2qAd8kF5mmiEZcYj/iMpI=;
        fh=V2KL2WPNklQIwpAe2Bv0SddZX68COc+gM+HXUQnvEdE=;
        b=Jef3ATcYpw+lrKndK9Dn6uztlnGhRDtWu+/dFIuzJvlMtnSRHRGW8wYkEPy7IjtWRQ
         2rt1ozamBLTeGcUp19cnHYuIKPLAfGYIEZc+fbAlKFx+4liY2Myd7MGjb1et0ytP+Jyf
         5l98tJVRSom6qjJaJZKih6i9TU5hIORpV+GmGHQLJHwmIINgyfQplC+nJrhwsEYuQbZk
         ubKG7e3vmV2ScKbIP3uS617KxWD0qDte62FZTrqQ76mXz6c2X6dke4u3rORw0G3CHnCk
         0iE4Uma6l6fn3KOjEoSH94YMLTzxBwUgvu1yJNFIoHmKh2RoTvbdCU8SAuVmyAf4NSoM
         khJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771187383; x=1771792183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpCYDdCiDeg+luhgldp27Z2qAd8kF5mmiEZcYj/iMpI=;
        b=TrqH4eQjR9Ayp5Wo1c9Mcrwzu+boPciSS2xpP0fow7mLVOqNMPnyORYCewgokYHRLC
         OlmeDwJyRE9Akw1jIP4Qf8e8WFkQAnm7NRO/5mFCu4FIpz3Lv/zwmB/vaSbj3Zcft4r4
         asJO5TT6JNu5uoOc2/2paVHBLqr8tVmBc8Y5k4Zx9WaD50howSUgwLAvTLqFmcQhFyKr
         6CXr0Hh1fnUDKdQlE3QDbLBweX86eb5wFiLxjay+bYUwd83I0jNCgH7xwwxj4iCW/CoU
         kIrKDTEcTSRh73tpNJowTQVpE3HpdjFuwzOl7x5xaPIsKYOsdgohDRD8IvNUc38SDMkG
         4Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771187383; x=1771792183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpCYDdCiDeg+luhgldp27Z2qAd8kF5mmiEZcYj/iMpI=;
        b=LM9dovqry3YLUFZ7AaWSy3XDefgiKKP8dcZuI2AIvDZC56q99InzKRSRRZMIN7zlCa
         ysvtPAHQCYq8XtizbQSrpiXv1XrO06A1Fz+tVA7DwO9zMafnqF3KAHDK0gAVaVp42RbT
         rQNNWZ5moyFGl8WPT4iq1wFTNvYN/hidOYFJ7te0H82VYX5joZxHlUpDJSCHi2dUfep5
         N1cx8Xc05ternfnv2paDcngXnL5SgraP7XPt+aWcttbnjSbmwlfmSRGpGuDR4CNDkSq1
         ciy4rlhDvXdAgzZyIbE0SmrB/NfMh0yn5L9FUj3xIxRnERQ8dlDosUSP1l2vdMlVP32o
         B4lg==
X-Forwarded-Encrypted: i=1; AJvYcCWVAtKmfJV+bsPCMhksyIhyhV6HGMyEY/Rueupuf8LDJqP046Et3CQmDVyDgGZcavLQW2buJTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EszIx+rqtQ/X2haVRBXhqOZYNHACIo518YMzCaVV3WVnzFrp
	sL23R0V+nRLMe8tE5V33ZrXmfIp5kClUE/WAhL53v7pnJsuVVsYogUlZ5pVn87cCfgaaQoQtRe3
	Fx0Bw99qym/TnhRtdN2bdPVCbbgCR9vU=
X-Gm-Gg: AZuq6aLRtAJXt3NHZs8nQlVGqudo+koeSCfaLX0TkGYpMuMPm3YpsPKtY5kq5dHkANN
	16kw9yt8p2N+VaAsaca4WVh7y0y5qvVpgIio7OZLZ45x2vnQ4Pw72ZixCCqZzXoXlwKgARMY+My
	emLsaYm1KXvj+2QgkpDioyGT+P7zNC9Nb64HbqkliABGlgy09GTrso8Kb6PsH0Q8REelmesjhN1
	zvdEOsg4L79pkdpZSq18tiAGwxRbKhz+EaqM5KKAA+Eirqzq8EPbEB4uOS3O9Y9zhFWWmjpsSgJ
	shuBFg==
X-Received: by 2002:a05:620a:2942:b0:8ca:2cf9:819b with SMTP id
 af79cd13be357-8cb422696a6mr1011942885a.30.1771187383348; Sun, 15 Feb 2026
 12:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214001535.435626-1-kartikey406@gmail.com>
In-Reply-To: <20260214001535.435626-1-kartikey406@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 04:29:32 +0800
X-Gm-Features: AaiRm50syQHB3kctGnJnEjyiXqT8j1X7hIANEB9brrbUxqOPyK3vC3uGRbBzxPE
Message-ID: <CAGsJ_4xZd9QCjcJo+j-iWox+O61+MJKui54pqek072LdSnh26w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	lance.yang@linux.dev, i@maskray.me, shy828301@gmail.com, 
	ackerleytng@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216639-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,maskray.me,gmail.com,google.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 43E4213FA5C
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 8:15=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
> (e.g. guest_memfd and secretmem). These files are created via
> alloc_file_pseudo(), which does not call get_write_access() and leaves
> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
> true, they appear as read-only regular files when
> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
> collapse.
>
> Anonymous inodes can never pass the inode_is_open_for_write() check
> since their i_writecount is never incremented through the normal VFS
> open path. The right thing to do is to exclude them from THP eligibility
> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
> filesystem files (e.g. shared libraries), not for pseudo-filesystem
> inodes.
>
> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
> large folios in the page cache via the collapse path, but the
> guest_memfd fault handler does not support large folios. This triggers
> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
>
> For secretmem, collapse_file() tries to copy page contents through the
> direct map, but secretmem pages are removed from the direct map. This
> can result in a kernel crash:
>
>     BUG: unable to handle page fault for address: ffff88810284d000
>     RIP: 0010:memcpy_orig+0x16/0x130
>     Call Trace:
>      collapse_file
>      hpage_collapse_scan_file
>      madvise_collapse
>
> Secretmem is not affected by the crash on upstream as the memory failure
> recovery handles the failed copy gracefully, but it still triggers
> confusing false memory failure reports:
>
>     Memory failure: 0x106d96f: recovery action for clean unevictable
>     LRU page: Recovered
>
> Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
> anonymous inode files.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D33a04338019ac7e43a44
> Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=3DU6rs=
6S7iP0gkR9enr7HoGtA@mail.gmail.com
> Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D33a04338019ac7e43a44
> Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility"=
)
> Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

