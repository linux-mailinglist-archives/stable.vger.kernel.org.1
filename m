Return-Path: <stable+bounces-195040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61808C66E14
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 02:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A55C4E1160
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C630BF6D;
	Tue, 18 Nov 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svVUH5ST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4613D8B1;
	Tue, 18 Nov 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430320; cv=none; b=qLhUQPXQF+uRyDzogbOoEcESdCOVXGTiLIYjMLbrX/MXZ/qRJ3A7sc5HREa9NfTE9byLQe9+t/XDpMJZdAanN1m8oGQvY3Ju94KpmEZCJ3ew6TK1/Y87+NY8IkzbL0APBWxnQkaJt6LRC02sc0pwAbXgQRC54RSrZUStpxNycIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430320; c=relaxed/simple;
	bh=8BLonCtVGo7oWPKTbBIr2mR9kjUSrGZ05CDBk4uzAxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8r9OvH8T4snaJ15/fvXlW0pC3oIYCGApA84orole9gI5RcDwL+jSQ5BJrgMY9DxVfPxsniBUdyncK0NFiq/aJu5+F3Y0Qedecfe0td1NtRrf1NAWMcJFVTe46Sr7GNRAM0Re/Lz1xmCaWbmqFeqCPDMVbI0UP5OqzWfC4CePwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svVUH5ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAAEC2BC87;
	Tue, 18 Nov 2025 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763430319;
	bh=8BLonCtVGo7oWPKTbBIr2mR9kjUSrGZ05CDBk4uzAxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svVUH5STgoBGPxTB9mVfBZolv2Xts0XSZEKr7m++912MJ4a+jtYIgXYczHJtvPgMW
	 /jrm2O8PIRNCruoqlYteZD+0BOgbL21k1iCjd04DIKc3ELn4WgSQe/uINiVDrZGsK0
	 ICQWVnHJEgyT+4NOAW4umFoIO/PfEdgfTjnCmHAI=
Date: Mon, 17 Nov 2025 20:45:17 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Message-ID: <2025111708-deplored-mousy-1b27@gregkh>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
 <20251117174315.367072-2-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117174315.367072-2-gulam.mohamed@oracle.com>

On Mon, Nov 17, 2025 at 05:43:15PM +0000, Gulam Mohamed wrote:
> This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.
> 

No reason why?

:(

