Return-Path: <stable+bounces-223255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN2kMEC1qWkZCwEAu9opvQ
	(envelope-from <stable+bounces-223255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:54:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D8215996
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D49D1305F336
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC933D9035;
	Thu,  5 Mar 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="DWMrLR4m"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F683D6CDC
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729623; cv=none; b=Fl97phclem6adN5CiHS+LX0n7LYLGzBUdw7b90Sj7OIsF74+eUc3P4q/2lnrUxl5RfLjiKzqbLKfJUHKt3yWFwiAeJwXaUPbN1YbAwLeLO/+CYz9QdQzsspQrwyG97E33S7Dtm5Sl/zDIf5KT9IG+OmS2a9Ofy77EFT6xqC1noI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729623; c=relaxed/simple;
	bh=LIWsH1el7vDPFBJn5lHbWQyWM/F3MELRI9wB13kjxjY=;
	h=From:Subject:In-Reply-To:To:Cc:Content-Type:References:Date:
	 Message-Id:Mime-Version; b=Oje8tB3rEfNkR66EEs+tcOmv2TtRcRRrkkZv8EGBAUa6j+VCZgftbgdt9xytznZhvuWo3MyYmG8UguuHGFeHM2DLV0LsAN4O83cRnkkC9Mb+7s5/QuFNNmmHSkZq92xtezvMZzOJQ1KwpVhAwdoD4F876BjpfD7SRrFGIQlxzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=DWMrLR4m; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1772729615;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=YEY9ooahCr3JYq53FbHOZeBSZtgvHTtqNqnl5vIPbv4=;
 b=DWMrLR4mvbNIt7uYc6gK4eQUJ1we2mKbNZX51L2yOjrPXVK7A7mxpp/S2mRua3O9fZHY8L
 fXyHSVYNe+fHy9kp0tzmPX7ANiiFwn3hn15VelXhLhsdibF7PL+gzlXel+WE3gl1Na8Ujq
 1LDSHQViPxME5TXLeFK8sPes8cHsEyNUIPWBatcpfLBLfdO/Ne2tI7z1V1T0ZmgweC6ifB
 mz99rIMMGcUPjrZkAEOXvu4Uhs5Aa45cmSo1ldHK6L/DvHNE7arUcQs2B3/s0eCHU5IlXE
 bU8aEmqcg1OakB2WC5wfdYAXY+WD4C2Iz7AFZdakIs8XyuoEDAPdhZzzH8iVyA==
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: md/bitmap: fix GPF in write_page caused by resize race
In-Reply-To: <aamyMEUBy4Lcgecg@qmqm.qmqm.pl>
To: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
	"Jack Wang" <jinpu.wang@ionos.com>
Cc: "Sasha Levin" <sashal@kernel.org>, <stable@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
Received: from [192.168.1.104] ([39.182.0.182]) by smtp.feishu.cn with ESMTPS; Fri, 06 Mar 2026 00:53:32 +0800
Content-Transfer-Encoding: quoted-printable
References: <aamyMEUBy4Lcgecg@qmqm.qmqm.pl>
X-Lms-Return-Path: <lba+269a9b50d+4fd08a+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Date: Fri, 6 Mar 2026 00:53:31 +0800
Message-Id: <b18b12cb-0a26-49cf-bddf-1f053d02743f@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Rspamd-Queue-Id: 3F2D8215996
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas-com.20200927.dkim.feishu.cn:dkim,fnnas.com:replyto,fnnas.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com]
X-Rspamd-Action: no action

Hi,

=E5=9C=A8 2026/3/6 0:41, Micha=C5=82 Miros=C5=82aw =E5=86=99=E9=81=93:
> Hi,
>
> Commit 5f73c8b33df9 ("md/bitmap: fix GPF in write_page caused by resize
> race") in stable 6.19 killed my machine. I confirmed that after reverting
> this commit the machine boots fine. The same commit was backported into
> 6.18 stable and shows the same symptoms. I tried the revert only with 6.1=
9,
> though, as that revived my workflow.
>
> For context, I have several md devices, some with internal bitmaps and
> dm-crypt on top.  md3 and md4 belong to a single LVM VG. In the locked
> up state I was able to see `mdadm`, some `udev-trigger` and `mount` tasks
> all hanging in D state.

Thanks for the report. Do you have the log of task stack of these tasks?
This will be very helpful to locate the root cause.

>
> /proc/mdstat:
>
> md9 : active raid1 sdc1[0] sdh1[1]
>        547584 blocks super 1.0 [2/2] [UU]
>
> md3 : active raid1 sdg3[3] sdb3[2]
>        669920064 blocks super 1.2 [2/2] [UU]
>        bitmap: 2/5 pages [8KB], 65536KB chunk
>
> md0 : active raid1 sdb1[5] sda1[3]
>        123892 blocks super 1.2 [3/2] [UU_]
>
> md4 : active raid1 sde[0](W) nvme0n1[2] nvme1n1[3]
>        488254464 blocks super 1.2 [3/3] [UUU]
>        bitmap: 0/4 pages [0KB], 65536KB chunk
>
> md1 : active raid1 sda2[2] nvme4n1p1[4]
>        234305112 blocks super 1.2 [2/2] [UU]
>        bitmap: 2/2 pages [8KB], 65536KB chunk
>
> Best Regards
> Micha=C5=82 Miros=C5=82aw

--=20
Thansk,
Kuai

