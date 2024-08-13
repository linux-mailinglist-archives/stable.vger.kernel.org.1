Return-Path: <stable+bounces-67509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EE9508A7
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5DA284773
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A819EEBF;
	Tue, 13 Aug 2024 15:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CF19E838
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562002; cv=none; b=Od2JWV/JBBf8TpmFcf635eYPyMTj4JL/AAry83vNOWkHGvnizFE8tMtQyApws7pPQfGppUrq/vRm7M8qsevNfdUQZAST45WilLzUP/0uI1NmGUyB8ymq6A52NAABd5ScrkVZfFyqZmk/FOpWRcLBgTrVTcX8+LCNptT20omB4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562002; c=relaxed/simple;
	bh=VM6sfRtZqM1zaLgM5XSUYFHXOa2Q/+uyjTIeD++/nXE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=cFkxKD93e1dLZqwcCMk0kNFIqjRLnUSKTqGxDsVtCxl22PIsLZ/dGManVBhb8CAAZg3y5X+BXuvJh0DQxLsOcYgOy+9cTFriONNMJHRNkV5yGvxKgTc9wiEt8TsDJwvqgpJh9FlKgnxG7J92/dv/TlnpboWhIG3VDSCFv4I7ea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1sdt88-00008k-Ah
	for stable@vger.kernel.org; Tue, 13 Aug 2024 17:08:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: Ian Pilcher <arequipeno@gmail.com>
Subject: Re: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error"
Date: Tue, 13 Aug 2024 10:08:07 -0500
Message-ID: <v9fssn$13au$1@ciao.gmane.io>
References: <20240813131900.1285842-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20240813131900.1285842-2-cassel@kernel.org>
Cc: linux-ide@vger.kernel.org

On 8/13/24 8:19 AM, Niklas Cassel wrote:
> This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.
> 
> Sense data can be in either fixed format or descriptor format.
> 
> SAT-6 revision 1, "10.4.6 Control mode page", defines the D_SENSE bit:
> "The SATL shall support this bit as defined in SPC-5 with the following
> exception: if the D_ SENSE bit is set to zero (i.e., fixed format sense
> data), then the SATL should return fixed format sense data for ATA
> PASS-THROUGH commands."
> 
> The libata SATL has always kept D_SENSE set to zero by default. (It is
> however possible to change the value using a MODE SELECT SG_IO command.)
> 
> Failed ATA PASS-THROUGH commands correctly respected the D_SENSE bit,
> however, successful ATA PASS-THROUGH commands incorrectly returned the
> sense data in descriptor format (regardless of the D_SENSE bit).
> 
> Commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
> CK_COND=1 and no error") fixed this bug for successful ATA PASS-THROUGH
> commands.
> 
> However, after commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE
> bit for CK_COND=1 and no error"), there were bug reports that hdparm,
> hddtemp, and udisks were no longer working as expected.
> 
> These applications incorrectly assume the returned sense data is in
> descriptor format, without even looking at the RESPONSE CODE field in the
> returned sense data (to see which format the returned sense data is in).
> 
> Considering that there will be broken versions of these applications around
> roughly forever, we are stuck with being bug compatible with older kernels.

I suppose it's a small quibble, but I don't think it's fair to say that
the applications are behaving incorrectly.  They assume that the
returned sense data is in descriptor format because it always was.  That
doesn't seem unreasonable.

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================



