Return-Path: <stable+bounces-223254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANs1OjyyqWnNCgEAu9opvQ
	(envelope-from <stable+bounces-223254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA7215819
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696B23017075
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCB3CA481;
	Thu,  5 Mar 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fmGJlWM6"
X-Original-To: stable@vger.kernel.org
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA493386C3E;
	Thu,  5 Mar 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728887; cv=none; b=uY/2f0AxBpBrGyWScBABgN0wjyq6tjyq22Mj26JdQ95aiRUuLodeu004ck02PJAYqtZeYoE3YZe/hvUdxFn6b+tuHxfgQD8Mr5KMZAgmO4AVMcJ44JD6F4aJcG1hcKBmyD1kQWhBP2CqRbfVqVuN3pdJSvgxpNanUwNuzHjTaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728887; c=relaxed/simple;
	bh=aMOy1pij3gc61bW3RFkRQkFTzV1u7fzcDZXCPql7Ip4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GPmwEa0g0mhzbapnR/E7ao+v0ZR8+Bj2rGpAkFcugsZXiI8bQnnjWkXerqv77dDEwvBtQ9IvhUGW3NBAhu9loxY4Wt2prGFsx91sFyVRX70ZPcK9kYZPpdt6MhxHDB02lry4C9NHybS7pOYfoHmVN2YokbpTfbWyTcpxholiUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=fmGJlWM6; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1772728882; bh=aMOy1pij3gc61bW3RFkRQkFTzV1u7fzcDZXCPql7Ip4=;
	h=Date:From:To:Cc:Subject:From;
	b=fmGJlWM6YfQmx5fAVrhvOM2NgFBK8VR0RLZmQ9eKAB70Zz7mpn+yISeBZzusgjGQj
	 Dfg6ExXId9C+Kfrq8LYEx/v9215HjbBD58KjxSnQHEv6dYnlfj0v8bMLi0E4woGZAq
	 dKOOOC9pSV8eB7Bo4XPQRJfTfU+y+DVv2LGSQfUobCUZSukNTnbzcn3KiaHjBNutWo
	 AXVO99p1sP1BkR5su7BhVRJd/566jk+3Y/IuitqgcIyzlQnFHhJtm/X10xy+5Skd9l
	 Orvoe5xjzNydCN43HF/Z9wxd8Ek14IUkRpL7WniySUmhI4QKHU3PYA7B/MiMgPEXMy
	 8K09COAoycgjg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4fRb02244kzXm;
	Thu, 05 Mar 2026 17:41:22 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 5 Mar 2026 17:41:20 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: Yu Kuai <yukuai@fnnas.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: md/bitmap: fix GPF in write_page caused by resize race
Message-ID: <aamyMEUBy4Lcgecg@qmqm.qmqm.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65EA7215819
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.45 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[rere.qmqm.pl,reject];
	R_DKIM_ALLOW(-0.20)[rere.qmqm.pl:s=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223254-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rere.qmqm.pl:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mirq-linux@rere.qmqm.pl,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rere.qmqm.pl:dkim,qmqm.qmqm.pl:mid]
X-Rspamd-Action: no action

Hi,

Commit 5f73c8b33df9 ("md/bitmap: fix GPF in write_page caused by resize
race") in stable 6.19 killed my machine. I confirmed that after reverting
this commit the machine boots fine. The same commit was backported into
6.18 stable and shows the same symptoms. I tried the revert only with 6.19,
though, as that revived my workflow.

For context, I have several md devices, some with internal bitmaps and
dm-crypt on top.  md3 and md4 belong to a single LVM VG. In the locked
up state I was able to see `mdadm`, some `udev-trigger` and `mount` tasks
all hanging in D state.

/proc/mdstat:

md9 : active raid1 sdc1[0] sdh1[1]
      547584 blocks super 1.0 [2/2] [UU]

md3 : active raid1 sdg3[3] sdb3[2]
      669920064 blocks super 1.2 [2/2] [UU]
      bitmap: 2/5 pages [8KB], 65536KB chunk

md0 : active raid1 sdb1[5] sda1[3]
      123892 blocks super 1.2 [3/2] [UU_]

md4 : active raid1 sde[0](W) nvme0n1[2] nvme1n1[3]
      488254464 blocks super 1.2 [3/3] [UUU]
      bitmap: 0/4 pages [0KB], 65536KB chunk

md1 : active raid1 sda2[2] nvme4n1p1[4]
      234305112 blocks super 1.2 [2/2] [UU]
      bitmap: 2/2 pages [8KB], 65536KB chunk

Best Regards
Micha³ Miros³aw

