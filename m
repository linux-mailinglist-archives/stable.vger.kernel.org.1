Return-Path: <stable+bounces-225424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGozHstqtWkq0QAAu9opvQ
	(envelope-from <stable+bounces-225424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 15:03:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3528D6C1
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5D5303989D
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCB378D89;
	Sat, 14 Mar 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naAjBzjc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA098374E62
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773497025; cv=none; b=C2Eh9ry8vI65AQrVpSBT/XR9PMLtnZpDzMjj6Fcb0TT2DM/nuWbkeQsBW4VLV2LYyguW9vJVV5qQSgP9byw5hOzuZ3Pfn7uclrsi72dOJaaiQTLe7zM4NgjGmyRAWwjwtYJccIw3+V/azbZZjqqeFacu+H82JvEcfBliH1fsyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773497025; c=relaxed/simple;
	bh=sgPSEBXiJzbLUZfpo/yiL7lSsuvwcrEZVoSXxcN8Trg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RlcdeAek5Ay1ndD2XVkRrXzChP64gFqzx7cDO/tgIk5nhgg/l/bJmIqxmnUaADAobGfi9C67bbp4AHUxN/Gtaj9i8N0XPODqoTlC5Jg9EmAo+EwAzzZZllBA94ynlm1To53dqU4NThDA6YSYrMPMV1iZ62ur8sU5hmPN30ug+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naAjBzjc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd80bea5f3so194734285a.3
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773497023; x=1774101823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozggT4VxXxi8nNocpv6bPtGBFv9+GusqHxKISYZjKwg=;
        b=naAjBzjcKOhTPuzjMw4A3c5mCvmKOuEcqDolxMAdROPVIR2Zqvb992FrptAvczZ1Gv
         Cn8B73JNKdfMpD+oaeptKTMvvjU8qVWvVDgf5wT8jCUNnvkOib1QFKooFYxXyl3SJ9tN
         PzICESDCJbEG675cNKUQiKoJyUdRI645Zr1NDLldq33XuNn3RBBTEGdTSA8ycXmeu5+Y
         c709/5Zzv/RuBR6IV2NaQN7A5M5j+H0tI6QwawR013pc35SUmj9x+dw/fDEr++4WNhKZ
         lVtK29R2wwfYfHf38f7ZthLHstSdCeGGBJP6JSmQin4Rr91JwrZUXCNZ3KTOnmHI9LTQ
         2CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773497023; x=1774101823;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozggT4VxXxi8nNocpv6bPtGBFv9+GusqHxKISYZjKwg=;
        b=nm42VTS2jccQtnhFko7peCAjjEy30vF4rCPMvYH753TWFDUO5og/rNtRdfK/Gp7spA
         izsPdc/LYihviRo+/HGPYzALmmUQL7p2UhA1O9hMkk+Iq1Gx8pOy35zyrVh00CLcDqj2
         ZwxC6uSs9qEi1RXlaS2WTEaV3iU0gb4lWCbq86rMbo60n39b5NoLrAINb1AZo4bbPfjX
         NHxbF5eDOB/7f2LkZPtD5QRwmZTcgQSTU7GZ1wrM7+LpKpwraufeK0m1T0CKudB/vExG
         c1GoXWjTV5S/IDHivJQlgsiD54AS1/lsIrUnWagFiWWP+Ux6VM/oB86c1eIbShMj6RLj
         vLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRtpMdmmrWaNr3uzooNplCVftNMy8dyYpKXfv0kRj243GEwyRl5UfF1QCVlbrI6ZvPlRgaz+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlfDwn89CVaKNp4Ht2JQ8fYUKFrWnGLMDqW0NPARUNvgknZQl
	KR5XPauqO2ZKgIvx6tfD1PzZm+xpQdRv4QfQg5iRNyJMkjDORM8/dqPt
X-Gm-Gg: ATEYQzx98oTVRGwZwET7cz/LQpQipJSHgTUj7AWNqgUz5qhSWyxcI9nJwqBNwgM3PhH
	xYygk/6Om/7vTdJ67VEg7TdwiNYIFdZJ6IUgBhkfE//hhqJZbA6bptbtC+LrXQUfF3vYOvSWic9
	TzGJrrtdOaQiYVVuFhaPEpdiFkYdtRKdiMIqiHdv7OJYiReeT8Ak0toikiO6nyPsaDpFA6FoA8b
	ZdOtlIuvZgWqhujF9bN2KIw2KxCjSkITq03KRQxnHqhW1+7daOmUsEOlzjuzYXETMkLvwq5PtEM
	RZDxhLWRraMCarEwfaPHcjDO7bKhX8ONzvwDbUhVaX1AAnM0KaGSWth0uZYX6UONFq6zG+GgBnf
	R/yIj1ykxQG3pik9OyZmHYp+LIYOU6+2ifnOkzb6aWIkiN8E/XTQZmfWKHCshb+nLeLY9snnXoq
	Ac08vuo1JHRMjdbOmLTS5c2v8qYNt9TZJQiT0z8D/Vhsy4FerjREatGpADERo42TXhmbvXjQ==
X-Received: by 2002:a05:6214:5907:b0:89c:44f9:e879 with SMTP id 6a1803df08f44-89c44f9e989mr4328376d6.49.1773497022499;
        Sat, 14 Mar 2026 07:03:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfc85dsm78266516d6.37.2026.03.14.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:03:41 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id F187DBE2EE7; Sat, 14 Mar 2026 15:03:38 +0100 (CET)
Date: Sat, 14 Mar 2026 15:03:38 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alejandro Olivan Alvarez <alejandro.olivan.alvarez@gmail.com>
Cc: 1130336@bugs.debian.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [regression] Network failure beyond first connection after
 69894e5b4c5e ("netfilter: nft_connlimit: update the count if add was
 skipped")
Message-ID: <177349610461.3071718.4083978280323144323@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eldamar.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18F3528D6C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Control: forwarded -1 https://lore.kernel.org/regressions/177349610461.3071718.4083978280323144323@eldamar.lan
Control: tags -1 + upstream

Hi

In Debian, in https://bugs.debian.org/1130336, Alejandro reported that
after updates including 69894e5b4c5e ("netfilter: nft_connlimit:
update the count if add was skipped"), when the following rule is set

	iptables -A INPUT -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset

connections get stuck accordingly, it can be easily reproduced by:

# iptables -A INPUT -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset
# nft list ruleset
# Warning: table ip filter is managed by iptables-nft, do not touch!
table ip filter {
        chain INPUT {
                type filter hook input priority filter; policy accept;
                ip protocol tcp xt match "connlimit" counter packets 0 bytes 0 reject with tcp reset
        }
}
# wget -O /dev/null https://git.kernel.org/torvalds/t/linux-7.0-rc3.tar.gz
--2026-03-14 14:53:51--  https://git.kernel.org/torvalds/t/linux-7.0-rc3.tar.gz
Resolving git.kernel.org (git.kernel.org)... 172.105.64.184, 2a01:7e01:e001:937:0:1991:8:25
Connecting to git.kernel.org (git.kernel.org)|172.105.64.184|:443... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-7.0-rc3.tar.gz [following]
--2026-03-14 14:53:51--  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-7.0-rc3.tar.gz
Reusing existing connection to git.kernel.org:443.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/x-gzip]
Saving to: ‘/dev/null’

/dev/null                         [                         <=>                    ] 248.03M  51.9MB/s    in 5.0s

2026-03-14 14:53:56 (49.3 MB/s) - ‘/dev/null’ saved [260080129]

# wget -O /dev/null https://git.kernel.org/torvalds/t/linux-7.0-rc3.tar.gz
--2026-03-14 14:53:58--  https://git.kernel.org/torvalds/t/linux-7.0-rc3.tar.gz
Resolving git.kernel.org (git.kernel.org)... 172.105.64.184, 2a01:7e01:e001:937:0:1991:8:25
Connecting to git.kernel.org (git.kernel.org)|172.105.64.184|:443... failed: Connection timed out.
Connecting to git.kernel.org (git.kernel.org)|2a01:7e01:e001:937:0:1991:8:25|:443... failed: Network is unreachable.

Before the 69894e5b4c5e ("netfilter: nft_connlimit: update the count
if add was skipped") commit this worked.

#regzbot introduced: 69894e5b4c5e28cda5f32af33d4a92b7a4b93b0e
#regzbot link: https://bugs.debian.org/1130336

Regards,
Salvatore

