Return-Path: <stable+bounces-86751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768059A35DC
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D8A1C23CD7
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1E18787A;
	Fri, 18 Oct 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XrQfAE99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D817DFEB
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233758; cv=none; b=LQ5U6SGlrfBVraPBitK56AYEeDl4nncVgoyeelW2lQvce0IM/jg/ygrBI7JBL3arrjJQM90v+MEu8Y4poMJfGbNkZooVWsoOgn0pvQ32xbBHxx0h26Nr7MLSpZA+RXv/ltMXkg+uHr9xeNkpllnqMh8R9QmP5w9L2KpjRUvbGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233758; c=relaxed/simple;
	bh=ReU2QT8ZNSG1gRwWskMny6wQYE900vQYE+Z3O9hv1N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuYVh57VFm1K3iumALa3HIfCcO02JjfFL4JOcrLeQZaoP6ZPwuzQxDUS+8u3w0nif8q76QIFS3lZ56S+NJcHGIGOnY9icSyL4Mh+5Tcu+giGX8hoITB533crCB4Q3qzejP7QcdHDscqA9o57EiL2qpN8rEB6FUemTjcpys7pPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XrQfAE99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED9C4CEC3;
	Fri, 18 Oct 2024 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729233758;
	bh=ReU2QT8ZNSG1gRwWskMny6wQYE900vQYE+Z3O9hv1N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrQfAE99+J4Zbq7P9H9Uhq8RM+rf+gaLzG9K5mCHs6Q11Ka0SGxit+XTiwiEUZAGa
	 cGN4v3zURYpQnmsjq+UH5XAff3+tApKjgehbE1ZkaVdLZZ3QqLkjA48wa9AcSw2XHj
	 DAGxAn5H39gAXNHeAgFU94+BHQ8Ro2sNKmwQCem8=
Date: Fri, 18 Oct 2024 08:41:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
Subject: Re: [PATCH 6.1 00/19] Fix NULL pointer dereference for corrupted UDF
 filesystems
Message-ID: <2024101834-drone-cradling-459a@gregkh>
References: <20241017171915.311132-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017171915.311132-1-cascardo@igalia.com>

On Thu, Oct 17, 2024 at 02:18:56PM -0300, Thadeu Lima de Souza Cascardo wrote:
> UDF filesystems which have relocated blocks past the end of the device may
> lead to a dcache without an inode that would lead to a NULL pointer
> dereference, like this:

Now queued up, thanks.

greg k-h

