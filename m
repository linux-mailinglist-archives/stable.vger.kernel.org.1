Return-Path: <stable+bounces-230994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK96NtvoyWmP3QUAu9opvQ
	(envelope-from <stable+bounces-230994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:07:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB4354F4E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C8E30107ED
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81001280A5A;
	Mon, 30 Mar 2026 03:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W2y8IKxb"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39B13777E;
	Mon, 30 Mar 2026 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840023; cv=none; b=AhxZ2vpsSHPst2NshjvPr6I5W67i+IYPtqkLr2becTr14XF5GhLegQYbX54r/syqJO2QRrTb4SEHbEI5pviU/3D00ENAA3FmFXYLhDVT0fuf7IsT1Yyv/28k/CfQt0I574Ozmt43VO2ekHAdu0uv8D05kWRnPChwxI4fX8cd1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840023; c=relaxed/simple;
	bh=s1ORvitlM6cKBH4EOERpSveFXEdNu4754t+P205+oHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rq3B9WnDPRiAUUTgnFe0zy+9vyRbGr+HK4BPUDPRjw/TuQsqZx1QpHFK18a2mmzdt7HNK7a/DfI2WUbsz3NH81DcvwHVmAMymg5iSLgrkQcoy2M544UhMt+NylM8xLIQIsEj4T+4cP9QPIbuhbGXfN09NYZz7LeRhhRdmnHKWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W2y8IKxb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s1
	ORvitlM6cKBH4EOERpSveFXEdNu4754t+P205+oHQ=; b=W2y8IKxbNWOvF5wmT+
	IEhvZr4p9yLHU16dqPBElWyGq4l+OiUbCjPvjK/13J/hwjgj21Fn8TbC9ZjLz9fV
	n02OG8ANnhcITVnamkTr3tEWeuPZDO607arnR1Idus5Sw6k63sTk4a5hR193GLFR
	d1owvUvB/TNKcYy2nO7DUWPiQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHz+ic6MlpF_0pYA--.13504S2;
	Mon, 30 Mar 2026 11:06:05 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails
Date: Mon, 30 Mar 2026 11:06:03 +0800
Message-Id: <20260330030603.273404-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <acncI-IZhtdDsmJg@fedora>
References: <20260330014952.152776-1-yangxiuwei@kylinos.cn> <acncI-IZhtdDsmJg@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDHz+ic6MlpF_0pYA--.13504S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWkZr1xuF1rZrW8JrW5Wrg_yoW3Zrg_uF
	Z8Ww1UCw47GFyxJrnrGa15ZrZxC34xKrWkZrWkWrZIqryI9rZI9wn3JryFq3W8Ga18W34Y
	yF13Z3W8ur4v9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRuWlJUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwR0uvmnJ6J2DgQAA3b
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid]
X-Rspamd-Queue-Id: 7CDB4354F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ming,

On Mon, Mar 30, 2026 at 10:12:51AM +0800, Ming Lei wrote:
> Another fix is to clear `sdkp` and `goto out_put`:
>
> - clearing `sdkp` because the device is released already, and this way is `memory safe`
> - `goto out_put` can release disk centrally
>

Thank you for the suggestion.

As I understand it, the behaviour is the same as in v3: once
put_device(&sdkp->disk_dev) has run, scsi_disk_release() frees the
scsi_disk, so following with put_disk(gd) and goto out avoids the gendisk
leak and also avoids falling through to out_free, where kfree(sdkp) would
no longer be valid.

For now I am inclined to keep the v3 form for simplicity, but I am happy to
switch to your sdkp = NULL + goto out_put approach if you or the
maintainers would find that clearer or more consistent.

Thanks,
Yang Xiuwei


