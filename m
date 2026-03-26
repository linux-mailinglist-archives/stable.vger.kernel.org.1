Return-Path: <stable+bounces-230452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE2aEeIfxWnr6QQAu9opvQ
	(envelope-from <stable+bounces-230452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:00:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A722C334D7E
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B5433036EA7
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72F3F87EE;
	Thu, 26 Mar 2026 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CrdPpQma"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372353F7E89
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526295; cv=none; b=UdjTZ99VIr9CNTAANGjLd5cQolbpQhlU5lFbmwetn4cnXnEQZ8Wj0j3NEvdSgZES3JKU+T/787yXpctICrRGK5S2HpqT7I2cjgybdIMk4PBph315qxBKRqgAHZHIZOKb6uDejErNiG38sNkmZNqunVZGWUo19cW/HJEzY5guaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526295; c=relaxed/simple;
	bh=2/j+w6H1MsulsZSBcwGI+WNQZaLWSgSrac+Yc1uEUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL69k059OBEUY1I0tLwBbVFl+2h67ePKBK3IIDCSmkh+EzEuBquJTW+9oIk79a6ZV+Wd8Z24ZsfmT+afOHKLtPuRHTWjh0wGPNtoB6d+/qmV3thrb0FJBeGtT84fdjsp1SBbKAqzQgjTqOSQ09/OvhjSlTi0m7xTpNAAEgC5rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CrdPpQma; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-153.bstnma.fios.verizon.net [173.48.121.153])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62QBvvHQ020389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 07:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774526279; bh=/UKQ7z986HfCBu3OUXzVSTFsTaNs7vFdcYZOm+RDhDU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CrdPpQmaegCPU46tKbhWF3s3rOIW9IvNzZtL6k10sXzDYlQjH+V7xzzQRLL9+UrkB
	 b8D1mYi0QSIOveSjIvycV9vQwYIHSWgAC/nxstsdPcNFidyMBc7piellc+A+K1/0br
	 QhpsIF1ztEVrCpbp0miOwO4FCAidKQn2doaixKK1ZgMNgQlqCSdGjUMCLgiKUUohK/
	 XEGFQ9edFi7rjgmGmkmID5yv2b9r0b37dB5WkT90VDs/t/d+P3WYqq9SuScFMYd/np
	 /Z+DgxEMVr7GsDkLv3cufiJ7KbGU+2s8n8Nj/iYm+XUIXPLca1AP80WnqcFGe7a+nZ
	 7ChUlPzrQAIrA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EE8292E00DA; Thu, 26 Mar 2026 07:57:56 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Chen <me@linux.beauty>
Cc: "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org
Subject: Re: [PATCH v3] ext4: publish jinode after initialization
Date: Thu, 26 Mar 2026 07:57:46 -0400
Message-ID: <177452625029.1205486.10688089869136424604.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225082617.147957-1-me@linux.beauty>
References: <20260225082617.147957-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230452-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A722C334D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Feb 2026 16:26:16 +0800, Li Chen wrote:
> ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
> It used to set ei->jinode before jbd2_journal_init_jbd_inode(),
> allowing a reader to observe a non-NULL jinode with i_vfs_inode
> still unset.
> 
> The fast commit flush path can then pass this jinode to
> jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and
> may crash.
> 
> [...]

Applied, thanks!

[1/1] ext4: publish jinode after initialization
      commit: d4dfb4e294f762f0567c50ac6cd71ba02c976575

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

