Return-Path: <stable+bounces-111089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB9A21940
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F461885E1A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EACC1990DE;
	Wed, 29 Jan 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b="DYeBS6YW"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CB2D627
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140437; cv=none; b=eqJc/IYtGYdD9ZTt0NVgLWODUwX9E1R38L9HaHGZR+g+cHW1Ymgxoh52t+0cQ7GdIrKiyKm5q04qBKs0q5X+DAI2sRmKWMeuQjj1s5JVXmn4M1zAffoNBaJCCSXYIK9oVGyldB/3+YAe9z30Uv5Lv3vIu493tH0i23FKH8ocfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140437; c=relaxed/simple;
	bh=McXkt0XZfO+9ZVkOKbvQWHZsIWwIBER6wZM++fOr/fI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=huC4SuSTJ9lGb9T/6OQ7SMerQbkCZXNWBTDtAM9bP6ziG/Yk0fvxRbVDWmwz4++LVT1Q21t3mH8QjUPbbjxUxEfBZ1hF1wltb1ULZHQ5ky1BetZdKf5WV1HcOlQKcw1H8C4UWerBnNeiN8dD0TMkgJrb4/c+y5H5uHK08UltI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de; spf=pass smtp.mailfrom=kuehnke.de; dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b=DYeBS6YW; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuehnke.de
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4YjbF2106Dz496r;
	Wed, 29 Jan 2025 09:39:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kuehnke.de; s=key2;
	t=1738139990; bh=McXkt0XZfO+9ZVkOKbvQWHZsIWwIBER6wZM++fOr/fI=;
	h=Date:To:From:Subject:Cc:From;
	b=DYeBS6YWIxz9J1jiBfd1SfGfGK4es+0tFrjZWNZALBlSYp5wmrplOPohF+Ww8eZvu
	 T/pc8nsuVhFUhTsrwJL/2MnFOf64ybVhWKuzfAM76a/qeJE/I2PSp3SBpGxOsBy6m0
	 ETRwOMTHclxAmXI1FZHJhHYvhXBBcNJZdlhBjyp3VJ0l9M4VtMfyh4ZoJ1O39OemPf
	 MVWV7XjUFqHtZrHXl3n0fbnfQuDzVWRbmD9CnfPyrtABOTKTECni/Zr4NmgeTI18XB
	 9Qh9Yo75Mnipz+aOKpiGOLb1iGOlz7GPI6lDCJ+wV+kGIT78pKD7vdX1m2A0d1gz1E
	 3XenAdaMIfwFg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4YjbF20cYRz7x8t;
	Wed, 29 Jan 2025 09:39:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mx2f74.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4YjbF14YM9z8tXc;
	Wed, 29 Jan 2025 09:39:49 +0100 (CET)
Received: from [192.168.3.2] (p4feab3aa.dip0.t-ipconnect.de [79.234.179.170])
	by mx2f74.netcup.net (Postfix) with ESMTPSA id 27B15211EA;
	Wed, 29 Jan 2025 09:39:45 +0100 (CET)
Authentication-Results: mx2f74;
        spf=pass (sender IP is 79.234.179.170) smtp.mailfrom=christian@kuehnke.de smtp.helo=[192.168.3.2]
Received-SPF: pass (mx2f74: connection is authenticated)
Message-ID: <64f08e31-dff8-4e86-ac5a-95ddc756031e@kuehnke.de>
Date: Wed, 29 Jan 2025 09:39:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
From: =?UTF-8?Q?Christian_K=C3=BChnke?= <christian@kuehnke.de>
Subject: Request inclusion of 18676c6aab0863618eb35443e7b8615eea3535a9 into
 stable 6.6
Cc: dlemoal@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <173813998540.28239.13077967773752668599@mx2f74.netcup.net>
X-Rspamd-Queue-Id: 27B15211EA
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: BP6y/YNYqtDECJCTpG3U8bjGLkLzQ/y9bwylpFLfIZ1cp2Ji

Hi all,

I have been sent here from the linux-ide mailing list. Over there, I 
have reported an issue with the 6.6 stable series of the kernel, 
starting with 6.6.51. The root cause is as follows:

On 12.09.2024, commit 872f86e1757bbb0a334ee739b824e47c448f5ebc ("ata: 
libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf") was 
applied to 6.6, adding checks of ATA_QCFLAG_RTF_FILLED to libata_scsi. 
The patch seen in baseline commit 
18676c6aab0863618eb35443e7b8615eea3535a9 ("ata: libata-core: Set 
ATA_QCFLAG_RTF_FILLED in fill_result_tf()") should have gone together 
with this.

Without it, I receive errors retrieving SMART data from SATA disks via a 
C602 SAS controller, apparently because in this situation 
ATA_QCFLAG_RTF_FILLED is not set.

I applied 18676c6aab0863618eb35443e7b8615eea3535a9 from baseline to 
6.6.74 and the problem went away.

If you need any further information, do not hesitate to contact me 
(linux user since 0.99.x, but only debugging it once every few years or 
so...).

Regards
Christian



