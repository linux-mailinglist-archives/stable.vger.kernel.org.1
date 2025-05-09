Return-Path: <stable+bounces-142996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42425AB0CF5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72C01C2252E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9492741B5;
	Fri,  9 May 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Weg3KJcy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA6272E6B;
	Fri,  9 May 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778658; cv=none; b=HxDRMy2Tlo+wF4+AB9YbcfNU83wP7P7wUZ8XSdCtWr/io+yall06Wwjx7zoNSr6AiEnYAicnpOK7240tttLagY6DeSU6fhTWFIOMqiVhYmp9CbrHMmB+oIkvqe1oVPro4gH4ue8OM0LGzS69mQv27aQSr9RRMnEvrUO9reueLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778658; c=relaxed/simple;
	bh=Ql/RqmkYojQcGQ0EfLd1kl8icHakCphGsH1R0s3l5vs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AfVAOLLIlr7WlAKmYC6/w4ldylWUz1mKEgNLZ8etly8/8fFeCPICSQ48ZQyPXN2FGhVcbw4f/KFzvMgR35nyoAprA/GVpqxiVHd4H0W32RHzBlIumyE8/MPG1jPUtiyHDpSzdF1pSpWLp7LMS5YdINFSVomLth1TyyFMaTjxlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Weg3KJcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2788DC4CEE4;
	Fri,  9 May 2025 08:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746778658;
	bh=Ql/RqmkYojQcGQ0EfLd1kl8icHakCphGsH1R0s3l5vs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Weg3KJcyyjYxGZbdLsm0rMLMkCxscK++ucF5r3yCN3h2VuAi0/+LM/mRbH9D/fOgi
	 LTkQV47VYWhkgEQXS8LnyNYrRsNTWET6lWU0fohNbFKRdWhJQ9b7g5fAy3mJ8MD0+f
	 Fp1f6l6iE9ZyYZQYFhvRMI3bDHGMp8m5/iBAOwG/aTLawZTHo903y70aFOM9rHoO92
	 IQHxUuOx59SUZYdGrfm8Io2pEVgDBqJ2/szEDb5AjZ7tO/R8LOLKop2OCsbwlHy03y
	 y3c93UBXSWygqeI71VWzRWDmqPdXMl6V0dgGiB9Vs3K14nbsqxKED5Fi9dowlf9jod
	 lve9Flg2OHHIA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, 
 Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250507-fix_configfs-v3-0-fe2d96de8dc4@quicinc.com>
References: <20250507-fix_configfs-v3-0-fe2d96de8dc4@quicinc.com>
Subject: Re: [PATCH v3 0/3] configfs: fix bugs
Message-Id: <174677862396.1934573.4068910930493177460.b4-ty@kernel.org>
Date: Fri, 09 May 2025 10:17:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Wed, 07 May 2025 19:50:24 +0800, Zijun Hu wrote:
> 


Applied, thanks!

[1/3] configfs: Delete semicolon from macro type_print() definition
      commit: d78aa60cfa7ece7477a4089a3a4b520ec7beba1b
[2/3] configfs: Do not override creating attribute file failure in populate_attrs()
      commit: f830edbae247b89228c3e09294151b21e0dc849c
[3/3] configfs: Correct error value returned by API config_item_set_name()
      commit: bbb67d4f85fd00a216fca4ca048e15f8ff6a2195

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



