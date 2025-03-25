Return-Path: <stable+bounces-126569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D812BA703F4
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3613BFB9A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF525A65C;
	Tue, 25 Mar 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtzvYQBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19922257AF2;
	Tue, 25 Mar 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913376; cv=none; b=BiqJwmJwGD84p1c1hQpJInY1ODSSloDr7oN9VOpdux2IWJSsjW9/lyh2Rzr2wQ7EEb5FhpnbJk3tA57JUJBzadIfsWrNkpVZ14Fl/PNVnQOilxP19azE8dWm5RwYLmZKXXDcUJACek0wv+wEAaBJJ+WtE1AH1lG2QhW9Yophyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913376; c=relaxed/simple;
	bh=bCNYtSP3tAyRMXR7Sc1wsTnBur5wo77qqBswAs5LS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgOrrK42jviLBdhK49QsLsyAGn2jepymyqwJHg0prl3Izz1nq+6+eBAHbZFc+tAk5AAHehuzYrcoDKprMnbx+sdPiz6H4Ksg/qPRfM7JAvT6fn/o/658a3k8mx5vWM/0SxIduIKEV+03UFAHSqyAejnlZBS6bkyw4oSMlwh4zlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtzvYQBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73CBC4CEE4;
	Tue, 25 Mar 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913374;
	bh=bCNYtSP3tAyRMXR7Sc1wsTnBur5wo77qqBswAs5LS+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtzvYQBEVyt+u3uU29HGp66yTvpl3cCuxsFvap+RPQrMLhHD1uUfW3PWDGTuWO3e+
	 3Fx6VQwu0C6ECi6JoxgyGr+dqKQlDxe/8vMipr+Nx5+o3bibjTKNoHOIXWday11NwN
	 EfjG2O2QxbhIklmkTl8mlIRY7R5coLTvR9FB1Ge7Bi88yQMu0OM86RZCztWBCoLq4S
	 aEX10aRk9p3yAlPH7NyLragU/n2+3bOblmCZwLJsTFAu4Hx8kmUe0EharyNqMK6ic4
	 CjR6UW6Gee38V26xJsx9ngr+PbU8t4ei5nNTIO3cdD9mUVrzs12xBT4i0itO+3Rzgd
	 625rSYm+njv2g==
Date: Tue, 25 Mar 2025 15:36:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ovl: don't allow datadir only
Message-ID: <20250325-unartig-streben-4d18457a1139@brauner>
References: <20250325104634.162496-1-mszeredi@redhat.com>
 <20250325104634.162496-2-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325104634.162496-2-mszeredi@redhat.com>

On Tue, Mar 25, 2025 at 11:46:29AM +0100, Miklos Szeredi wrote:
> In theory overlayfs could support upper layer directly referring to a data
> layer, but there's no current use case for this.
> 
> Originally, when data-only layers were introduced, this wasn't allowed,
> only introduced by the "datadir+" feature, but without actually handling
> this case, resulting in an Oops.
> 
> Fix by disallowing datadir without lowerdir.
> 
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one")
> Cc: <stable@vger.kernel.org> # v6.7
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

