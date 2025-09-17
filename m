Return-Path: <stable+bounces-180462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FCB823ED
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 01:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C01582290
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438430B51D;
	Wed, 17 Sep 2025 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkEwXCGH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DA301484
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150810; cv=none; b=r2l4H3h0vRsOaJMGGrjLh9ORPTCo8tDLDirplMuhTlIBbZ5wuAeWQLjS6g0+sgbvMv+HVGc4eHIh43XPkbNe5NCrgzaA66XD8gFYCUplrnH/EoB6oVaRrLPvaUx0IpuXa6nxT3UmljO+tyskHfmtKlM8n1T0+aAic4JW5a9GbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150810; c=relaxed/simple;
	bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EoS5Y+RvbAsCXGIfObeJRnhpdVi4+fIrPJ1/1J4MFqlnvpg1kxVlomv/NC4QISVKSwN02HMK7pOw+XRDqBEqTPmFv7sHzruiTNwSHgPynBe9kyjdta23E7Xs9hqSBAnSFPdFur6jmQKztQv4iLUk083mi/8+4LoPe/kz9HaJcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkEwXCGH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso426290a12.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150807; x=1758755607; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
        b=EkEwXCGHd45o4gQ3TmHcUCVN/BHHQRBW/Wb+Df78OyjSaVqd2zpxwnAPSXEoOCPwEx
         JROrbqH6Wx+0VNHrBw6gHpDEuEbF7eDtEtKOOFcgASPnllzBsMo9+4+CTnyEC6Zkqk9R
         1vwromHs5UKaEutTkPpo70KKREq4aofPTJH52q+lC4PyfyNfeBbV8uZyVAYDZ1hCButJ
         p2KzZ4qweAbDuX/FU6X53r4tq36JXXLhTgUS2S6K0BWaxTKu6QqtUfKHpdidScQpCHFD
         DHyhREQ98dn0UYiWl1i1f+lzwS1aoJ72V/cmbN+FNeZPwx3iQOjivn8qFQSOBrNSRrr0
         H5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150807; x=1758755607;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XiYO7bxY3Db6NEw7v4TiSKU5u4AGw26sTZNdVrYAko=;
        b=UAsUxYnneDYFy11pn5ueHLMimVey7DsPjOolc+sGAA7XhWk0u3xog/WSK0WKG5x0fb
         I+QYQsFhglg1aQNvfJ2uYg1bu2GPMsvIWgoUHO/BDWcs4W/HWmgo98vBQSWNHIlI5U7+
         cIGZjDhLVyjTvKTreARUTlunDsXzuHjGUukMwGmIAY5MIVX9Yu6PnhjzxXwaoUEkYC3N
         zhrBQwKgPrSvxm5GBR6MYeIh2tt1BQyDHn4wYxIqIMXDppMiDtMznmGJV9U0mOTbOAww
         kk4bFkhZY+atrV95mJTwLP03NbhpHLYmLX+5wqjZszSyTI4SIhJ8wFkaq6nsYwCFYKzL
         oBgg==
X-Gm-Message-State: AOJu0Yzr/efvm2z8A3JzLaG0DIhzZIms1O2AIGsBABM6yyMRWCTVMERH
	yxyycUoq5CZ627VIM9Byn5leToHypgExyprou5NeoCCS+g3di+ch+aODw2x8z4VI
X-Gm-Gg: ASbGncuXMc5g8Lpg6HO7DXvqpBNv23HCpIn2tjsq7tbQEB8oHCvBDK7q2zWtloN8ETl
	29R/i0ILcHjM0MzVjMDESybzJk7wlututRBHo2rXSAcAlYnTDPrMhEv5/i95so/7PifOEqduaBI
	2/1CgstHfMnCl4a3z6Icr+qhbmLpaqSUzmIkK5aKi+Lc0hnEwhn7hqnr6VRQFwoXDaD1NfBn5FN
	pD/8oMjV8FE67Fgezdtrw9stGEh9n+BXA3o3gbjgOidyyp9MpTiHAxSRVSf/zERX9Bc7+Bm//EB
	T+dbeqs+X9Nh92ayo0LPBKbzR5kmrhSbxpZkZ22lNSVzWHpjXcjZVRAVZ85HgYINPFc2VKWOEa1
	1XW+4m8EvSsNVKYcmsmBo2CH2BlKWLBTK1T+KlqVNwPTg/+i9bLjEfKgUxRwB7JZYVEdN
X-Google-Smtp-Source: AGHT+IG98aQ5FwXvLTrJD63OHQ0Iwiuhiyghh+T8O/k661ClbeZPhpM/Dtz/FiShgdzzaGKD9JUgvA==
X-Received: by 2002:a17:906:dc91:b0:b04:6cf7:75cd with SMTP id a640c23a62f3a-b1bbd77a791mr420272066b.54.1758150807361;
        Wed, 17 Sep 2025 16:13:27 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fcfe88badsm62702366b.52.2025.09.17.16.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 16:13:26 -0700 (PDT)
Message-ID: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Subject: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Thu, 18 Sep 2025 01:13:24 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I would like to request backporting 5326ab737a47 ("virtio_console: fix
order of fields cols and rows") to all LTS kernels.

I'm working on QEMU patches that add virtio console size support.
Without the fix, rows and columns will be swapped.

As far as I know, there are no device implementations that use the
wrong order and would by broken by the fix.

Note: A previous version [1] of the patch contained "Cc: stable" and
"Fixes:" tags, but they seem to have been accidentally left out from
the final version.

[1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.co=
m/

Thanks,
Filip Hejsek

